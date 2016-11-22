//
//  NewsletterViewController.swift
//  SVNewsletter
//
//  Created by Sam on 20/11/2016.
//  Copyright © 2016 Semyon Vyatkin. All rights reserved.
//

import UIKit

protocol NewsletterInterface: class {
    func showNewsletters(newsletters: [NewsEntity])
}

class NewsletterViewController: UIViewController, NewsletterInterface {
    @IBOutlet weak private var tableView: UITableView!
    
    var newsletters = [NewsEntity]()
    var presenter: NewsletterPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configAppearance()
        configNavigation()
        
        presenter.updateNewsletterListView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }    
    
    // MARK: - TableView Appearance
    private func configAppearance() {
        self.automaticallyAdjustsScrollViewInsets = false
        self.edgesForExtendedLayout = []
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 125.0
        
        self.tableView.register(UINib(nibName: NewsletterTableViewCell.identifier, bundle: Bundle.main),
                                forCellReuseIdentifier: NewsletterTableViewCell.identifier)
    }
    
    private func configNavigation() {
        
    }
    
    // MARK: - Newsletter Interface
    func showNewsletters(newsletters: [NewsEntity]) {
        self.newsletters = newsletters
        self.tableView.reloadData()
    }
}
