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
    func fetchNewsletters(isNeedRefresh: Bool)
}

protocol NewsletterInteractorOutput: class {
    func fetchedNewsletters(_ newsletters: [NewsEntity])
    func fetchFailedWithException(_ exception: NSError?)
}

class NewsletterInteractor: NewsletterInteractorInput {
    private var netService = NetworkService()
    private var pendingOperation: OperationQueue = {
        let queue = OperationQueue()
        queue.name = "SVNewsletter::ParsingDataQueue"
        queue.maxConcurrentOperationCount = 1
        queue.qualityOfService = .userInitiated
        
        return queue
    }()
    
    weak var interactorOutput: NewsletterInteractorOutput!
    
    // MARK: - NewsletterInteractorInput
    func fetchNewsletters(isNeedRefresh: Bool) {
        let app = UIApplication.shared.delegate as? AppDelegate
        
        if isNeedRefresh {
            app?.dataService.clearData()
            downloadNewsletters()
        }
        else {
            let sort = NSSortDescriptor(key: "publicationDate", ascending: false)
            guard let newsletters = app?.dataService.fetchData(nil, sorts: [sort]), newsletters.count > 0 else {
                downloadNewsletters()
                return
            }
            
            interactorOutput.fetchedNewsletters(newsletters)
        }
    }
    
    private func downloadNewsletters() {
        netService.request(url: URLPaths.news.url(),
                           completionBlock: { [weak self] data in
                            guard data != nil else {
                                self?.interactorOutput.fetchFailedWithException(nil)
                                return
                            }
                            
                            let operation = NewsletterOperation(data: (data as! JSON).arrayValue, { [weak self] (newsEntities) in
                                self?.interactorOutput.fetchedNewsletters(newsEntities)
                            })
                            
                            self?.pendingOperation.addOperation(operation)
            }, exceptionBlock: { [weak self] exception in
                self?.interactorOutput.fetchFailedWithException(exception)
        })
    }
}
