//
//  NewsletterDetailsWireframe.swift
//  SVNewsletter
//
//  Created by Sam on 23/11/2016.
//  Copyright © 2016 Semyon Vyatkin. All rights reserved.
//

import Foundation
import UIKit

class NewsletterDetailsWireframe {
    var newsletterDetailsPresenter: NewsletterDetailsPresenter!
    
    init() {
        newsletterDetailsPresenter = NewsletterDetailsPresenter()
    }
    
    func presentNewsletterDetails(info: [UIViewController : NewsEntity]) {
        info.keys.first?.performSegue(withIdentifier: "NewsletterDetailsSegue", sender: info)
    }
    
    func setupNewsletterDetails(_ controller: NewsletterDetailsViewController) {
        let newsletterDetailsInteractor = NewsletterDetailsInteractor()
        
        controller.presenter = newsletterDetailsPresenter
        
        newsletterDetailsPresenter.newsletterDetailsView = controller
        newsletterDetailsPresenter.interactor = newsletterDetailsInteractor
        newsletterDetailsPresenter.wireframe = self
        
        newsletterDetailsInteractor.interactorOutput = newsletterDetailsPresenter
    }
}
