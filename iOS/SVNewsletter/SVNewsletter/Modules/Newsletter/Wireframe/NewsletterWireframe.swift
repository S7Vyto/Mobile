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
    func configurateDetailsInteface(_ controller: NewsletterDetailsViewController)
    
    func showLoadingIndicator()
    func dismissLoadingIndicator()
}

class NewsletterWireframe: NewsletterWireframeProtocol {
    weak var newsletterController: NewsletterViewController?
    var rootWireframe: Wireframe?
    
    let loadingIndicator = LoadingViewController.indicator    
    let newsletterPresenter: NewsletterPresenter
    let detailsWireframe = NewsletterDetailsWireframe()
    
    init() {
        let newsletterInteractor = NewsletterInteractor()
        
        newsletterPresenter = NewsletterPresenter()
        newsletterPresenter.interactor = newsletterInteractor
        newsletterPresenter.wireframe = self
        
        newsletterInteractor.interactorOutput = newsletterPresenter
    }
    
    func presentNewsletterListView(_ window: UIWindow?) {
        newsletterController = rootWireframe?.viewControllerWith(name: "NewsletterViewController") as? NewsletterViewController
        newsletterController?.presenter = newsletterPresenter
        
        newsletterPresenter.newsletterListView = newsletterController
        
        assert(newsletterController != nil, "Controller can't be empty")
        rootWireframe?.showRootViewController(newsletterController!, in: window)
    }
    
    // MARK: - NewsletterWireframe Protocol
    func showLoadingIndicator() {
        assert(newsletterController != nil, "Controller can't be empty")
        loadingIndicator.showFrom(newsletterController!, with: "Обновление новостей")
    }
    
    func dismissLoadingIndicator() {
        loadingIndicator.dismiss()        
    }
    
    func presentExceptionMessage(_ exceptionMsg: String) {
        let controller = UIAlertController(title: "Error", message: exceptionMsg, preferredStyle: .alert)
        let done = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        controller.addAction(done)
        newsletterController?.present(controller, animated: true, completion: nil)
    }
    
    func presentDetailsInterface(for newsletter: NewsEntity) {
        detailsWireframe.detailsPresenter.newsletter = newsletter
        detailsWireframe.sourceController = newsletterController
        
        detailsWireframe.presentNewsletterDetails()
    }
    
    func configurateDetailsInteface(_ controller: NewsletterDetailsViewController) {
        detailsWireframe.configurateDetailsInterface(controller)
    }
}
