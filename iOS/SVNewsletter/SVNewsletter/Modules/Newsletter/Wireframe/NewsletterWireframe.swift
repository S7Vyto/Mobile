//
//  NewsletterWireframe.swift
//  SVNewsletter
//
//  Created by Sam on 21/11/2016.
//  Copyright © 2016 Semyon Vyatkin. All rights reserved.
//

import Foundation
import UIKit

protocol NewsletterWireframeProtocol {
    func presentDetailsInterface(for newsletter: NewsEntity)
    func showLoadingIndicator()
    func dismissLoadingIndicator()
}

class NewsletterWireframe: NewsletterWireframeProtocol {
    weak var newsletterController: NewsletterViewController!
    var loadingIndicator = LoadingViewController.indicator
    
    var newsletterPresenter: NewsletterPresenter!
    var rootWireframe: Wireframe!
    
    init() {
        let newsletterInteractor = NewsletterInteractor()
        
        newsletterPresenter = NewsletterPresenter()
        newsletterPresenter.interactor = newsletterInteractor
        newsletterPresenter.wireframe = self
        
        newsletterInteractor.interactorOutput = newsletterPresenter
    }
    
    func presentNewsletterListView(_ window: UIWindow?) {
        newsletterController = rootWireframe.viewControllerWith(name: "NewsletterViewController") as! NewsletterViewController
        newsletterController.presenter = newsletterPresenter
        
        newsletterPresenter.newsletterListView = newsletterController
        rootWireframe.showRootViewController(newsletterController, in: window)
    }
    
    // MARK: - NewsletterWireframe Protocol
    func showLoadingIndicator() {
        loadingIndicator.showFrom(newsletterController)
    }
    
    func dismissLoadingIndicator() {
        loadingIndicator.dismiss()        
    }
    
    func presentExceptionMessage(_ exceptionMsg: String) {
        let controller = UIAlertController(title: "Error", message: exceptionMsg, preferredStyle: .alert)
        let done = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        controller.addAction(done)
        newsletterController.present(controller, animated: true, completion: nil)
    }
    
    func presentDetailsInterface(for newsletter: NewsEntity) {
        let newsletterDetailsWireframe = NewsletterDetailsWireframe()
        newsletterDetailsWireframe.newsletterDetailsPresenter.newsletter = newsletter
        newsletterDetailsWireframe.presentNewsletterDetails(info: [newsletterController : newsletter])
    }
}
