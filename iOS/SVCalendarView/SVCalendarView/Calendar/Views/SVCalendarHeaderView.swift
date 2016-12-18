//
//  SVCalendarHeaderView.swift
//  SVCalendarView
//
//  Created by Semyon Vyatkin on 04/11/2016.
//  Copyright © 2016 Semyon Vyatkin. All rights reserved.
//

import UIKit

class SVCalendarHeaderView: UICollectionReusableView {
    static var identifier: String {
        return NSStringFromClass(SVCalendarHeaderView.self).replacingOccurrences(of: "SVCalendarView.", with: "")
    }
    
    fileprivate let style = SVCalendarConfiguration.shared.styles.header1
    
    var title: String? {
        didSet {
            guard let titleLabel = self.viewWithTag(SVCalendarComponentTag) as? UILabel else {
                return
            }
            
            titleLabel.text = title
        }
    }
    
    // MARK: - View LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configAppearance()
        configTitleLabel()
    }
    
    // MARK: - View Appearance
    fileprivate func configAppearance() {
        self.backgroundColor = style.background.normalColor
    }
    
    fileprivate func configTitleLabel() {
        var titleLabel = self.viewWithTag(SVCalendarComponentTag) as? UILabel
        if titleLabel == nil {
            titleLabel = SVCalendarComponents.cellLabel(with: title ?? "-").value() as? UILabel
            
            self.addSubview(titleLabel!)
            
            let bindingViews = [
                "titleLabel" : titleLabel!
            ]
            
            let vertConst = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[titleLabel]-0-|", options: [], metrics: nil, views: bindingViews)
            let horizConst = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[titleLabel]-0-|", options: [], metrics: nil, views: bindingViews)
            
            self.addConstraints(vertConst)
            self.addConstraints(horizConst)                        
        }
        
        titleLabel?.font = style.text.font
        titleLabel?.textColor = style.text.normalColor
        titleLabel?.text = title
    }
}
