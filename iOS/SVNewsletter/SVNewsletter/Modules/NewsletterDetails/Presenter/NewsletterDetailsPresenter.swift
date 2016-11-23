//
//  NewsletterDetailsPresenter.swift
//  SVNewsletter
//
//  Created by Sam on 23/11/2016.
//  Copyright © 2016 Semyon Vyatkin. All rights reserved.
//

import Foundation

protocol NewsletterDetailsPresenterInteface: class {
    func updateNewsletterDetails()
}

class NewsletterDetailsPresenter: NewsletterDetailsPresenterInteface, NewsletterDetailsInteractorOutput {
    weak var newsletterDetailsView: NewsletterDetailsInterface?
    
    var interactor: NewsletterDetailsInteractorInput!
    var wireframe: NewsletterDetailsWireframe!
    
    var newsletter: NewsEntity!
    
    // MARK: - NewsletterDetailsPresenterInteface
    func updateNewsletterDetails() {
        guard let _ = newsletter.content else {
            interactor.fetchNewsletterDetails(newsletter.id!)
            return
        }
        
        newsletterDetailsView?.showNewsletterDetails(newsletter: newsletter)
    }
    
    // MARK: - NewsletterDetailsInteractor Output
    func fetchedNewsletters(_ newsletters: [NewsEntity]) {
        guard let news = newsletters.first else {
            return
        }
        
        newsletterDetailsView?.showNewsletterDetails(newsletter: news)
    }
    
    func fetchFailedWithException(_ exception: NSError?) {
        guard let errorMsg = exception?.userInfo["errorMsg"] as? String else {
            return
        }
        
        print(errorMsg)
    }
}
