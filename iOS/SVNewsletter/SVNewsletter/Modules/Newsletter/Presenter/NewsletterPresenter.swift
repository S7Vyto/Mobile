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
    
    func showDetails(for newsletter: NewsEntity)
    func configDetails(_ controller: NewsletterDetailsViewController)
}

class NewsletterPresenter: NewsletterPresenterInteface, NewsletterInteractorOutput {
    weak var newsletterListView: NewsletterInterface!
    
    var interactor: NewsletterInteractorInput!
    var wireframe: NewsletterWireframe!
    
    var newsletters = [NewsEntity]()
    
    // MARK: - NewsletterPresenterInterface
    func updateNewsletters() {
        wireframe.showLoadingIndicator()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: { [weak self] in
                self?.interactor.fetchNewsletters()
        })
    }
    
    func syncNewsletters() {
        DispatchQueue.global(qos: .userInitiated)
            .asyncAfter(deadline: .now() + 1, execute: { [weak self] in
                self?.interactor.updateNewsletters()
            })
    }
    
    func showDetails(for newsletter: NewsEntity) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: { [weak self] in
            self?.wireframe.presentDetailsInterface(for: newsletter)
        })
    }
    
    func configDetails(_ controller: NewsletterDetailsViewController) {
        wireframe.configurateDetailsInteface(controller)
    }
    
    // MARK: - NewsletterInteractorOutput
    func fetchedNewsletters(_ newsletters: [NewsEntity]) {
        newsletterListView.showNewsletters(newsletters: newsletters)
        wireframe.dismissLoadingIndicator()
    }
    
    func fetchFailedWithException(_ exception: NSError?) {
        guard let errorMsg = exception?.userInfo["errorMsg"] as? String else {
            return
        }
        
        wireframe.presentExceptionMessage(errorMsg)
    }
}

