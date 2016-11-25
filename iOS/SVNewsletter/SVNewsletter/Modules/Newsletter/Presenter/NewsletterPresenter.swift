//
//  NewsletterPresenter.swift
//  SVNewsletter
//
//  Created by Sam on 21/11/2016.
//  Copyright © 2016 Semyon Vyatkin. All rights reserved.
//

import Foundation

protocol NewsletterPresenterInteface: class {
    func updateNewsletters()
    func syncNewsletters()
    func showDetails(forNewsletter newsletter: NewsEntity)    
}

class NewsletterPresenter: NewsletterPresenterInteface, NewsletterInteractorOutput {
    weak var newsletterListView: NewsletterInterface!
    
    var interactor: NewsletterInteractorInput!
    var wireframe: NewsletterWireframe!
    
    var newsletters = [NewsEntity]()
    
    // MARK: - NewsletterPresenterInterface
    func updateNewsletters() {
        interactor.fetchNewsletters()
    }
    
    func syncNewsletters() {
        interactor.updateNewsletters()
    }
    
    func showDetails(forNewsletter newsletter: NewsEntity) {
        wireframe.presentDetailsInterface(for: newsletter)
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

