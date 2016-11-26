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
            NSForegroundColorAttributeName: UIColor.rgb(245.0, 245.0, 245.0),
            NSFontAttributeName: UIFont.systemFont(ofSize: 12.0)
        ]
        
        control.tintColor = UIColor.rgb(248.0, 248.0, 28.0)
        control.attributedTitle = NSAttributedString(string: "Обновление данных...",
                                                     attributes: options)
        control.addTarget(self, action: #selector(refreshContent), for: .valueChanged)
        
        return control
    }()
    
    private lazy var backgroundLayer: CAGradientLayer = {
        let bgLayer = CAGradientLayer()
        bgLayer.frame = self.view.bounds
        bgLayer.shouldRasterize = true
        bgLayer.rasterizationScale = UIScreen.main.scale
        bgLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        bgLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        bgLayer.colors = [
            UIColor.rgb(52.0, 73.0, 93.0).cgColor,
            UIColor.rgb(40.0, 55.0, 71.0).cgColor
        ]
        bgLayer.locations = [
            0.0,
            1.0
        ]
        
        return bgLayer
    }()
    
    var newsletters = [NewsEntity]()
    var presenter: NewsletterPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configAppearance()
        configNavigation()
        
        presenter.updateNewsletters()
    }

    override func didReceiveMemoryWarning() {
        newsletters.removeAll()
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        newsletters.removeAll()
    }
    
    // MARK: - TableView Appearance
    private func configAppearance() {
        self.automaticallyAdjustsScrollViewInsets = false
        self.edgesForExtendedLayout = []
        
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = UIColor.rgb(248.0, 248.0, 28.0)
        self.navigationController?.navigationBar.barTintColor = UIColor.rgb(51.0, 43.0, 77.0)
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName: UIColor.rgb(248.0, 248.0, 28.0),
            NSFontAttributeName: UIFont.systemFont(ofSize: 16)
        ]
        
        self.view.backgroundColor = UIColor.clear
        self.view.layer.masksToBounds = true
        self.view.layer.insertSublayer(backgroundLayer, at: 0)
        
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
        presenter.syncNewsletters()        
    }
    
    // MARK: - Newsletter Interface
    func showNewsletters(newsletters: [NewsEntity]) {
        if refreshControl.isRefreshing {
            refreshControl.endRefreshing()
        }
        
        self.newsletters = newsletters
        self.tableView.reloadData()
    }
    
    // MARKL - Navigation 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NewsletterDetailsSegue" {
            guard let configurated = segue.destination as? NewsletterDetailsViewController else {
                return
            }
            
            presenter.configDetails(configurated)
        }
    }
}
