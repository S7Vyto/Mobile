//
//  NewsletterDetailsPresenter.swift
//  SVNewsletter
//
//  Created by Sam on 23/11/2016.
//  Copyright © 2016 Semyon Vyatkin. All rights reserved.
//

import Foundation

protocol NewsletterDetailsPresenterInteface: class {
    func updateNewsletterView()
}

class NewsletterDetailsPresenter: NewsletterDetailsPresenterInteface {    
    weak var newsletterDetailsView: NewsletterDetailsInterface!
    
    var interactor: NewsletterInteractorInput!
    var wireframe: NewsletterDetailsWireframe!
    
    var newsletter: NewsEntity!
    
    // MARK: - NewsletterDetailsPresenterInteface
    func updateNewsletterView() {
         newsletterDetailsView.showNewsletterDetails(newsletter: newsletter)        
    }
}
