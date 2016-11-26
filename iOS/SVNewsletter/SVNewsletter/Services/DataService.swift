//
//  DataService.swift
//  SVNewsletter
//
//  Created by Sam on 23/11/2016.
//  Copyright © 2016 Semyon Vyatkin. All rights reserved.
//

import Foundation
import CoreData
import SwiftyJSON

class DataService {
    private let modelName = "NewsModel"
    
    private var mainContext: NSManagedObjectContext!
    private var privateContext: NSManagedObjectContext!
    
    init() {
        guard let modelPath = Bundle.main.url(forResource: modelName, withExtension: "momd") else {
            fatalError("Error loading model from main bundle")
        }
        
        guard let objectModel = NSManagedObjectModel(contentsOf: modelPath) else {
            fatalError("Error initializing model from path: \(modelPath)")
        }
        
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: objectModel)
        
        mainContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        mainContext.name = "MainManagedContext"
        mainContext.undoManager = nil
        mainContext.persistentStoreCoordinator = coordinator
        
        privateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        privateContext.name = "PrivateManagedContext"
        privateContext.undoManager = nil
        privateContext.parent = mainContext
        
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsUrl = urls[urls.endIndex - 1]
        let databaseUrl = documentsUrl.appendingPathComponent("NewsData.sqlite")
        
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType,
                                               configurationName: nil,
                                               at: databaseUrl,
                                               options: nil)
        }
        catch {
            fatalError("Error migrating database store: \(error.localizedDescription)")
        }
    }
    
    func clearData() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "NewsEntity")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.includesPropertyValues = false
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        mainContext.performAndWait { [weak self] in
            do {
                try self?.mainContext.execute(deleteRequest)
                
                do {
                    try self?.mainContext.save()                    
                }
                catch {
                    fatalError("Failure to save data in main context: \(error.localizedDescription)")
                }
            }
            catch {
                fatalError("Failed to delete all data from database \(error.localizedDescription)")
            }
        }
    }
    
    func saveData(_ json: [JSON], _ completionBlock: @escaping (Void) -> Void) {
        privateContext.perform { [unowned self] in
            for data in json {
                let newsEntity = NSEntityDescription.insertNewObject(forEntityName: "NewsEntity", into: self.privateContext) as! NewsEntity
                newsEntity.id = data["id"].stringValue
                newsEntity.name = data["name"].stringValue
                newsEntity.text = data["text"].stringValue.removeSpecialSymbols()
                newsEntity.publicationDate = data["publicationDate"]["milliseconds"].doubleValue                                
            }
            
            do {
                try self.privateContext.save()
                self.mainContext.performAndWait { [weak self] in
                    do {
                        try self?.mainContext.save()
                        self?.mainContext.reset()
                        
                        DispatchQueue.main.async {
                            completionBlock()
                        }
                    }
                    catch {
                        fatalError("Failure to save data in main context: \(error.localizedDescription)")
                    }
                }
            }
            catch {
                fatalError("Failure to save data in private context: \(error.localizedDescription)")
            }
        }
    }
    
    func updateData(_ data: JSON, _ completionBlock: @escaping (String?) -> Void) {
        privateContext.perform { [weak self] in
            guard let newsEntity = self?.fetchData(data["title"]["id"].stringValue, sorts: nil)?.first else {
                completionBlock(nil)
                return
            }
            
            newsEntity.content = data["content"].stringValue.removeSpecialSymbols()
            newsEntity.creationDate = data["creationDate"]["milliseconds"].doubleValue
            newsEntity.modificationDate = data["lastModificationDate"]["milliseconds"].doubleValue
            
            do {
                try self?.privateContext.save()
                self?.mainContext.performAndWait { [weak self] in
                    do {
                        try self?.mainContext.save()                        
                        
                        DispatchQueue.main.async {
                            completionBlock(newsEntity.content)
                        }
                    }
                    catch {
                        fatalError("Failure to save data in main context: \(error.localizedDescription)")
                    }
                }
            }
            catch {
                fatalError("Failure to save data in private context: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchData(_ id: String?, sorts: [NSSortDescriptor]?) -> [NewsEntity]? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "NewsEntity")
        fetchRequest.returnsObjectsAsFaults = false
        
        if id != nil {
            fetchRequest.predicate = NSPredicate(format: "id == %@", id!)
            fetchRequest.fetchLimit = 1
        }
        
        if sorts != nil {
            fetchRequest.sortDescriptors = sorts
        }
        
        do {
            guard let fetchedData = try mainContext.fetch(fetchRequest) as? [NewsEntity] else {
                return nil
            }
            
            return fetchedData
        }
        catch {
            fatalError("Failed to fetch newsletters: \(error.localizedDescription)")
        }                
    }
}
