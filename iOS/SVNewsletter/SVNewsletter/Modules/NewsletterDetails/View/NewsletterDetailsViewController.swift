//
//  NewsletterDetailsViewController.swift
//  SVNewsletter
//
//  Created by Sam on 23/11/2016.
//  Copyright © 2016 Semyon Vyatkin. All rights reserved.
//

import UIKit

protocol NewsletterDetailsInterface: class {
    func showNewsletterDetails(newsletter: NewsEntity)
}

class NewsletterDetailsViewController: UIViewController, NewsletterDetailsInterface {
    var presenter: NewsletterDetailsPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - NewsletterDetailsInterface
    func showNewsletterDetails(newsletter: NewsEntity) {
        
    }
}
