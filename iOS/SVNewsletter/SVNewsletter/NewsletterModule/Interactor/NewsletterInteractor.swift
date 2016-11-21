//
//  NewsletterInteractor.swift
//  SVNewsletter
//
//  Created by Sam on 20/11/2016.
//  Copyright © 2016 Semyon Vyatkin. All rights reserved.
//

import Foundation

protocol NewsletterInteractorInput: class {
    func fetchNewsletters()
}

protocol NewsletterInteractorOutput: class {
    func fetchedNewsletters(_ newsletters: [NewsEntity])
    func fetchFailedWithException(_ exception: NSError?)
}

class NewsletterInteractor: NewsletterInteractorInput {
    private var netService = NetworkService()
    weak var interactorOutput: NewsletterInteractorOutput!
    
    // MARK: - NewsletterInteractorInput
    func fetchNewsletters() {
        netService.request(url: URLPaths.news.url(),
                           completionBlock: { [weak self] data in
                            self?.interactorOutput.fetchedNewsletters([])
        }, exceptionBlock: { [weak self] exception in                        
            self?.interactorOutput.fetchFailedWithException(exception)
        })
    }
}
