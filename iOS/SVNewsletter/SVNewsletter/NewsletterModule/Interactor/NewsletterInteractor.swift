//
//  NewsletterInteractor.swift
//  SVNewsletter
//
//  Created by Sam on 20/11/2016.
//  Copyright © 2016 Semyon Vyatkin. All rights reserved.
//

import Foundation

protocol NewsletterInteractorInput: class {
    func fetchNewsletters()
}

protocol NewsletterInteractorOutput: class {
    func fetchedNewsletters(_ newsletters: [NewsEntity])
}

class NewsletterInteractor: NewsletterInteractorInput {
    weak var interactorOutput: NewsletterInteractorOutput!
    
    // MARK: - NewsletterInteractorInput
    func fetchNewsletters() {
        
        
        interactorOutput.fetchedNewsletters([])
    }
}
