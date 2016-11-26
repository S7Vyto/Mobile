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
    
    var interactor: NewsletterDetailsInteractorInput?
    var wireframe: NewsletterDetailsWireframe?
    
    var newsletter: NewsEntity?
    
    // MARK: - NewsletterDetailsPresenterInteface
    func updateNewsletterDetails() {
        assert(newsletter != nil, "Newsletter can't be an empty value")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: { [unowned self] in
            self.wireframe?.showLoadingIndicator()
            self.interactor?.fetchNewsletterDetails(self.newsletter!)
        })
    }
    
    // MARK: - NewsletterDetailsInteractor Output
    func fetchedNewsletterDetails(_ content: String?) {
        wireframe?.dismissLoadingIndicator()
        
        newsletter?.content = content
        newsletterDetailsView?.showNewsletterDetails(content)
    }
    
    func fetchFailedWithException(_ exception: NSError?) {
        guard let errorMsg = exception?.userInfo["errorMsg"] as? String else {
            return
        }
        
        print(errorMsg)
    }
}
