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
    weak var newsletterDetailsView: NewsletterDetailsViewController!
    var newsletterDetailsPresenter: NewsletterDetailsPresenter!
    
    init() {
        newsletterDetailsPresenter = NewsletterDetailsPresenter()
    }
    
    func presentNewsletterDetails(from controller: UIViewController) {
        newsletterDetailsView = Wireframe.viewControllerWith(name: "NewsletterDetailsViewController") as! NewsletterDetailsViewController
        newsletterDetailsView.presenter = newsletterDetailsPresenter
        
        newsletterDetailsPresenter.newsletterDetailsView = newsletterDetailsView
        newsletterDetailsPresenter.wireframe = self
        
        controller.performSegue(withIdentifier: "NewsletterDetailsSegue", sender: controller)
    }
}
