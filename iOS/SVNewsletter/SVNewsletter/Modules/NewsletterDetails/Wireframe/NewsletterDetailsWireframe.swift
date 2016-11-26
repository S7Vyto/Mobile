//
//  NewsletterDetailsWireframe.swift
//  SVNewsletter
//
//  Created by Sam on 23/11/2016.
//  Copyright © 2016 Semyon Vyatkin. All rights reserved.
//

import Foundation
import UIKit

protocol NewsletterDetailsWireframeProtocol {
    func presentNewsletterDetails()
    func configurateDetailsInterface(_ controller: NewsletterDetailsViewController)
    
    func showLoadingIndicator()
    func dismissLoadingIndicator()
}

class NewsletterDetailsWireframe: NewsletterDetailsWireframeProtocol {
    weak var detailsViewController: NewsletterDetailsViewController?
    weak var sourceController: UIViewController?
    
    let detailsPresenter: NewsletterDetailsPresenter
    let loadingIndicator = LoadingViewController.indicator
    
    init() {
        let detailsInteractor = NewsletterDetailsInteractor()
        
        detailsPresenter = NewsletterDetailsPresenter()
        detailsPresenter.interactor = detailsInteractor
        detailsPresenter.wireframe = self
        
        detailsInteractor.interactorOutput = detailsPresenter
    }
    
    // MARK: - NewsletterDetailsWireframe Protocol
    func presentNewsletterDetails() {
        sourceController?.performSegue(withIdentifier: "NewsletterDetailsSegue", sender: nil)
    }
    
    func configurateDetailsInterface(_ controller: NewsletterDetailsViewController) {
        detailsViewController = controller
        
        detailsPresenter.newsletterDetailsView = detailsViewController
        detailsViewController?.presenter = detailsPresenter
    }
    
    func showLoadingIndicator() {
        loadingIndicator.showFrom(detailsViewController, with: "Загрузка описания")
    }
    
    func dismissLoadingIndicator() {
        loadingIndicator.dismiss()
    }
}
