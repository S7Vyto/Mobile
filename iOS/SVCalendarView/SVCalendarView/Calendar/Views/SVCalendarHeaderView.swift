//
//  SVCalendarHeaderView.swift
//  SVCalendarView
//
//  Created by Semyon Vyatkin on 04/11/2016.
//  Copyright © 2016 Semyon Vyatkin. All rights reserved.
//

import UIKit

class SVCalendarHeaderView: UICollectionReusableView {
    class var identifier: String {
        return NSStringFromClass(SVCalendarHeaderView.self).replacingOccurrences(of: "SVCalendarView.", with: "")
    }    
    
    // MARK: - View LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        configAppearance()
    }
    
    // MARK: - View Appearance
    fileprivate func configAppearance() {
        self.backgroundColor = UIColor.green
    }
}
