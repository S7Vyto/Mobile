//
//  NewsletterViewControllerExtension.swift
//  SVNewsletter
//
//  Created by Sam on 21/11/2016.
//  Copyright © 2016 Semyon Vyatkin. All rights reserved.
//

import Foundation
import UIKit

extension NewsletterViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - TableView Datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsletters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsletterTableViewCell.identifier, for: indexPath) as! NewsletterTableViewCell
        let newsletter = newsletters[indexPath.row]

        cell.desc = newsletter.desc
        
        return cell
    }
    
    // MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newsletterEntity = newsletters[indexPath.row]
        presenter.showDetails(forNewsletter: newsletterEntity)
    }
}
