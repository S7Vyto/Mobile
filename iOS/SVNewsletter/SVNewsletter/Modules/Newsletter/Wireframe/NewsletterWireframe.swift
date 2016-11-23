//
//  NewsletterWireframe.swift
//  SVNewsletter
//
//  Created by Sam on 21/11/2016.
//  Copyright © 2016 Semyon Vyatkin. All rights reserved.
//

import Foundation
import UIKit

protocol NewsletterWireframeInput {
    func setupDetailsInteface(_ controller: NewsletterDetailsViewController)
    func presentDetailsInterface(forNewsletter newsletter: NewsEntity)
    func presentExceptionMessage(_ exceptionMsg: String)
}

class NewsletterWireframe: NewsletterWireframeInput {
    weak var newsletterController: NewsletterViewController!
    var newsletterPresenter: NewsletterPresenter!
    
    var rootWireframe: Wireframe!
    var newsletterDetailsWireframe = NewsletterDetailsWireframe()
    
    init() {
        let newsletterInteractor = NewsletterInteractor()
        
        newsletterPresenter = NewsletterPresenter()
        newsletterPresenter.interactor = newsletterInteractor
        newsletterPresenter.wireframe = self
        
        newsletterInteractor.interactorOutput = newsletterPresenter
    }
    
    func presentNewsletterListView(_ window: UIWindow?) {
        newsletterController = Wireframe.viewControllerWith(name: "NewsletterViewController") as! NewsletterViewController
        newsletterController.presenter = newsletterPresenter
        
        newsletterPresenter.newsletterListView = newsletterController
        rootWireframe.showRootViewController(newsletterController, in: window)
    }
    
    // MARK: - NewsletterWireframe Input
    func presentExceptionMessage(_ exceptionMsg: String) {
        let controller = UIAlertController(title: "Error", message: exceptionMsg, preferredStyle: .alert)
        let done = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        controller.addAction(done)
        newsletterController.present(controller, animated: true, completion: nil)
    }
    
    func presentDetailsInterface(forNewsletter newsletter: NewsEntity) {
        newsletterDetailsWireframe.newsletterDetailsPresenter.newsletter = newsletter
        newsletterDetailsWireframe.presentNewsletterDetails(from: newsletterController)
    }
    
    func setupDetailsInteface(_ controller: NewsletterDetailsViewController) {
        newsletterDetailsWireframe.setupNewsletterDetails(controller)
    }
}
