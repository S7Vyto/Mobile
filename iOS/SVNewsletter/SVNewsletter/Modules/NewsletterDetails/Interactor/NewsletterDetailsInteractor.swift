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
    func fetchNewsletterDetails(_ newsletter: NewsEntity)
}

protocol NewsletterDetailsInteractorOutput: class {
    func fetchedNewsletterDetails(_ content: String?)
    func fetchFailedWithException(_ exception: NSError?)
}

class NewsletterDetailsInteractor: NewsletterDetailsInteractorInput {
    private var netService = NetworkService()
    
    weak var interactorOutput: NewsletterDetailsInteractorOutput?
    
    // MARK: - NewsletterInteractorInput
    func fetchNewsletterDetails(_ newsletter: NewsEntity) {
        guard let content = newsletter.content else {
            downloadNewsletterDetails(newsletter.id!)
            return
        }
        
        interactorOutput?.fetchedNewsletterDetails(content)
    }
    
    func downloadNewsletterDetails(_ id: String) {
        netService.request(url: URLPaths.content(id: id).url(),
                           completionBlock: { [weak self] data in
                            guard data != nil else {
                                self?.interactorOutput?.fetchFailedWithException(nil)
                                return
                            }
                            
                            weak var dataService = (UIApplication.shared.delegate as! AppDelegate).dataService
                            dataService?.updateData([data as! JSON].first!) { [weak self] content in
                                self?.interactorOutput?.fetchedNewsletterDetails(content)
                            }
            }, exceptionBlock: { [weak self] exception in
                self?.interactorOutput?.fetchFailedWithException(exception)
        })
    }
}
