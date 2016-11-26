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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0.0
        cell.layer.transform = CATransform3DMakeScale(1.0, 0.5, 0.5)

        UIView.animateKeyframes(withDuration: 0.65,
                                delay: 0.0,
                                options: .allowUserInteraction,
                                animations: { [weak cell] in
                                    cell?.alpha = 1.0
                                    cell?.layer.transform = CATransform3DMakeScale(1.0, 1.0, 1.0)
        }, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsletterTableViewCell.identifier, for: indexPath) as! NewsletterTableViewCell
        let newsletter = newsletters[indexPath.row]

        cell.desc = newsletter.text
        
        return cell
    }
    
    // MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? NewsletterTableViewCell else {
            return
        }
        
        cell.isTouched = true
        presenter.showDetails(for: newsletters[indexPath.row])
    }
}
