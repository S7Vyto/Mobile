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
    func presentDetailsInterface(forNewsletter newsletter: NewsEntity)
}

class NewsletterWireframe: NewsletterWireframeInput {
    weak var newsletterController: NewsletterViewController!
    var newsletterPresenter: NewsletterPresenter!
    
    var rootWireframe: Wireframe!
    var newsletterDetailsWireframe: NewsletterWireframe!
    
    init() {
        let newsletterInteractor = NewsletterInteractor()
        
        newsletterPresenter = NewsletterPresenter()
        newsletterPresenter.interactor = newsletterInteractor
        newsletterPresenter.wireframe = self
        
        newsletterInteractor.interactorOutput = newsletterPresenter
    }
    
    func presentNewsletterListView(_ window: UIWindow?) {
        newsletterController = newsletterListViewController()
        newsletterController.presenter = newsletterPresenter
        
        newsletterPresenter.newsletterListView = newsletterController
        rootWireframe.showRootViewController(newsletterController, in: window)
    }
    
    // MARK: - NewsletterWireframe Input
    func presentDetailsInterface(forNewsletter newsletter: NewsEntity) {
        
    }
    
    // MARK: - Wireframe Methods
    private func newsletterListViewController() -> NewsletterViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let controller = storyboard.instantiateViewController(withIdentifier: "NewsletterViewController") as! NewsletterViewController
        
        return controller
    }
}
