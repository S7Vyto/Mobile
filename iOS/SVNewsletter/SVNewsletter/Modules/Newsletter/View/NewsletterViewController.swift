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
   
    private lazy var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        let options = [
            NSForegroundColorAttributeName: UIColor.rgb(100.0, 100.0, 100.0),
            NSFontAttributeName: UIFont.systemFont(ofSize: 12.0)
        ]
        
        control.tintColor = UIColor.rgb(1.0, 1.0, 1.0)
        control.attributedTitle = NSAttributedString(string: "Обновление данных...",
                                                     attributes: options)
        control.addTarget(self, action: #selector(refreshContent), for: .valueChanged)
        
        return control
    }()
    
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
        
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.isTranslucent = true
        
        self.tableView.backgroundColor = UIColor.clear
        self.tableView.separatorColor = UIColor.clear
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 125.0
        
        self.tableView.addSubview(refreshControl)
        self.tableView.register(UINib(nibName: NewsletterTableViewCell.identifier, bundle: Bundle.main),
                                forCellReuseIdentifier: NewsletterTableViewCell.identifier)
    }
    
    private func configNavigation() {
        
    }
    
    @objc private func refreshContent(_ sender: UIRefreshControl) {        
        refreshControl.beginRefreshing()
        
        DispatchQueue.global(qos: .userInitiated)
            .asyncAfter(deadline: .now() + 1.5, execute: { [weak self] in
                self?.presenter.updateNewsletterListView()
        })
    }
    
    // MARK: - Newsletter Interface
    func showNewsletters(newsletters: [NewsEntity]) {
        if refreshControl.isRefreshing {
            refreshControl.endRefreshing()
        }
        
        self.newsletters = newsletters
        self.tableView.reloadData()
    }
}
