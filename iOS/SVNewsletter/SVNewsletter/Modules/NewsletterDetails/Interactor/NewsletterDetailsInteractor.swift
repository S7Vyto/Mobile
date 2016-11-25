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
    func fetchedNewsletterDetails()
    func fetchFailedWithException(_ exception: NSError?)
}

class NewsletterDetailsInteractor: NewsletterDetailsInteractorInput {
    private var netService = NetworkService()    
    weak var interactorOutput: NewsletterDetailsInteractorOutput!
    
    // MARK: - NewsletterInteractorInput
    func fetchNewsletterDetails(_ newsletter: NewsEntity) {
        guard let _ = newsletter.content else {
            self.downloadNewsletterDetails(newsletter.id!)
            return
        }
        
        self.interactorOutput.fetchedNewsletterDetails()
    }
    
    func downloadNewsletterDetails(_ id: String) {
        netService.request(url: URLPaths.content(id: id).url(),
                           completionBlock: { [weak self] data in
                            guard data != nil else {
                                self?.interactorOutput.fetchFailedWithException(nil)
                                return
                            }
                            
                            weak var dataService = (UIApplication.shared.delegate as! AppDelegate).dataService
                            dataService?.updateData([data as! JSON].first!) { [weak self] in
                                self?.interactorOutput.fetchedNewsletterDetails()
                            }
            }, exceptionBlock: { [weak self] exception in
                self?.interactorOutput.fetchFailedWithException(exception)
        })
    }
}
