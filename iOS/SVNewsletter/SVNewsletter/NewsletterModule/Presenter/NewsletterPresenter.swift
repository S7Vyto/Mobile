//
//  NewsletterPresenter.swift
//  SVNewsletter
//
//  Created by Sam on 21/11/2016.
//  Copyright © 2016 Semyon Vyatkin. All rights reserved.
//

import Foundation

protocol NewsletterPresenterInteface: class {
    func updateNewsletterListView()
    func showDetails(forNewsletter newsletter: NewsEntity)
}

class NewsletterPresenter: NewsletterPresenterInteface, NewsletterInteractorOutput {
    weak var newsletterListView: NewsletterInterface!
    
    var interactor: NewsletterInteractorInput!
    var wireframe: NewsletterWireframe!
    
    var newsletters = [NewsEntity]()
    
    // MARK: - Presenter LifeCycle
    init() {
        
    }
    
    // MARK: - NewsletterModuleInterface
    func updateNewsletterListView() {
        interactor.fetchNewsletters()
    }
    
    func showDetails(forNewsletter newsletter: NewsEntity) {
        wireframe.presentDetailsInterface(forNewsletter: newsletter)
    }
    
    // MARK: - NewsletterInteractorOutput
    func fetchedNewsletters(_ newsletters: [NewsEntity]) {
        guard newsletters.count > 0 else {
            return
        }
        
        newsletterListView.showNewsletters(newsletters: newsletters)
    }
}

