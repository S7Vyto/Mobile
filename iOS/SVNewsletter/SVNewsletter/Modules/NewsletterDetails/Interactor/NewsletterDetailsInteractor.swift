//
//  NewsletterDetailsInteractor.swift
//  SVNewsletter
//
//  Created by Sam on 23/11/2016.
//  Copyright © 2016 Semyon Vyatkin. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol NewsletterDetailsInteractorInput: class {
    func fetchNewsletterDetails(_ id: String)
}

protocol NewsletterDetailsInteractorOutput: class {
    func fetchedNewsletters(_ newsletters: [NewsEntity])
    func fetchFailedWithException(_ exception: NSError?)
}

class NewsletterDetailsInteractor: NewsletterDetailsInteractorInput {
    private var netService = NetworkService()
    private var pendingOperation: OperationQueue = {
        let queue = OperationQueue()
        queue.name = "SVNewsletter::ParsingDataQueue"
        queue.maxConcurrentOperationCount = 1
        queue.qualityOfService = .userInitiated
        
        return queue
    }()
    
    weak var interactorOutput: NewsletterDetailsInteractorOutput!
    
    // MARK: - NewsletterInteractorInput
    func fetchNewsletterDetails(_ id: String) {                
        netService.request(url: URLPaths.content(id: id).url(),
                           completionBlock: { [weak self] data in
                            guard data != nil else {
                                self?.interactorOutput.fetchFailedWithException(nil)
                                return
                            }
                            
                            let operation = NewsletterDetailsOperation(data: [data as! JSON], { [weak self] (newsEntities) in
                                self?.interactorOutput.fetchedNewsletters(newsEntities)
                            })

                            self?.pendingOperation.addOperation(operation)
            }, exceptionBlock: { [weak self] exception in
                self?.interactorOutput.fetchFailedWithException(exception)
        })
    }
}
