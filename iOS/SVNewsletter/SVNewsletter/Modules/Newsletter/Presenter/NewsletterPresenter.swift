//
//  NewsletterPresenter.swift
//  SVNewsletter
//
//  Created by Sam on 21/11/2016.
//  Copyright © 2016 Semyon Vyatkin. All rights reserved.
//

import Foundation

protocol NewsletterPresenterInteface: class {
    func updateNewsletterListView(isNeedRefresh: Bool)
    func showDetails(forNewsletter newsletter: NewsEntity)
    func setupDetails(_ controller: NewsletterDetailsViewController)
}

class NewsletterPresenter: NewsletterPresenterInteface, NewsletterInteractorOutput {
    weak var newsletterListView: NewsletterInterface!
    
    var interactor: NewsletterInteractorInput!
    var wireframe: NewsletterWireframe!
    
    var newsletters = [NewsEntity]()
    
    // MARK: - NewsletterPresenterInterface
    func updateNewsletterListView(isNeedRefresh: Bool) {
        interactor.fetchNewsletters(isNeedRefresh: isNeedRefresh)
    }
    
    func showDetails(forNewsletter newsletter: NewsEntity) {
        wireframe.presentDetailsInterface(forNewsletter: newsletter)
    }
    
    func setupDetails(_ controller: NewsletterDetailsViewController) {
        wireframe.setupDetailsInteface(controller)
    }
    
    // MARK: - NewsletterInteractorOutput
    func fetchedNewsletters(_ newsletters: [NewsEntity]) {                
        newsletterListView.showNewsletters(newsletters: newsletters)
    }
    
    func fetchFailedWithException(_ exception: NSError?) {
        guard let errorMsg = exception?.userInfo["errorMsg"] as? String else {
            return
        }
        
        wireframe.presentExceptionMessage(errorMsg)
    }
}

