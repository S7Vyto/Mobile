//
//  NewsletterTableViewCell.swift
//  SVNewsletter
//
//  Created by Sam on 22/11/2016.
//  Copyright © 2016 Semyon Vyatkin. All rights reserved.
//

import UIKit

class NewsletterTableViewCell: UITableViewCell {
    @IBOutlet weak private var descLabel: UILabel!
    
    static var identifier: String {
        return NSStringFromClass(self).replacingOccurrences(of: "SVNewsletter.", with: "")
    }
    
    var desc: String? {
        didSet {
            descLabel.text = desc
        }
    }
    
    // MARK: - Cell LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }    
}
