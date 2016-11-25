//
//  NewsletterInteractor.swift
//  SVNewsletter
//
//  Created by Sam on 20/11/2016.
//  Copyright © 2016 Semyon Vyatkin. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol NewsletterInteractorInput: class {
    func fetchNewsletters()
    func updateNewsletters()
}

protocol NewsletterInteractorOutput: class {
    func fetchedNewsletters(_ newsletters: [NewsEntity])
    func fetchFailedWithException(_ exception: NSError?)
}

class NewsletterInteractor: NewsletterInteractorInput {
    private var netService = NetworkService()
    private let app = UIApplication.shared.delegate as? AppDelegate
    
    weak var interactorOutput: NewsletterInteractorOutput!
    
    // MARK: - NewsletterInteractorInput
    func fetchNewsletters() {
        let sort = NSSortDescriptor(key: "publicationDate", ascending: false)
        guard let newsletters = app?.dataService.fetchData(nil, sorts: [sort]), newsletters.count > 0 else {
            updateNewsletters()
            return
        }
        
        interactorOutput.fetchedNewsletters(newsletters)
    }
    
    func updateNewsletters() {
        app?.dataService.clearData()
        downloadNewsletters()
    }
    
    private func downloadNewsletters() {
        netService.request(url: URLPaths.news.url(),
                           completionBlock: { [weak self] data in
                            guard data != nil else {
                                self?.interactorOutput.fetchFailedWithException(nil)
                                return
                            }
                            
                            weak var dataService = (UIApplication.shared.delegate as! AppDelegate).dataService
                            dataService?.saveData((data as! JSON).arrayValue) { [weak self] in
                                let sort = NSSortDescriptor(key: "publicationDate", ascending: false)
                                let newsletters = dataService?.fetchData(nil, sorts: [sort]) ?? []
                                
                                self?.interactorOutput.fetchedNewsletters(newsletters)                                
                            }
            }, exceptionBlock: { [weak self] exception in
                self?.interactorOutput.fetchFailedWithException(exception)
        })
    }
}
