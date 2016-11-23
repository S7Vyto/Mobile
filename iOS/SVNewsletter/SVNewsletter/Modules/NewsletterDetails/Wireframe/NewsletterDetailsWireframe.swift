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
    weak var newsletterDetailsView: NewsletterDetailsViewController?
    var newsletterDetailsPresenter: NewsletterDetailsPresenter!
    
    init() {
        newsletterDetailsPresenter = NewsletterDetailsPresenter()
    }
    
    func presentNewsletterDetails(from controller: UIViewController) {
        controller.performSegue(withIdentifier: "NewsletterDetailsSegue", sender: controller)
    }
    
    func setupNewsletterDetails(_ controller: NewsletterDetailsViewController) {
        let newsletterDetailsInteractor = NewsletterDetailsInteractor()
        
        newsletterDetailsView = controller
        newsletterDetailsView?.presenter = newsletterDetailsPresenter
        
        newsletterDetailsPresenter.newsletterDetailsView = newsletterDetailsView
        newsletterDetailsPresenter.interactor = newsletterDetailsInteractor
        newsletterDetailsPresenter.wireframe = self
        
        newsletterDetailsInteractor.interactorOutput = newsletterDetailsPresenter
    }
}
