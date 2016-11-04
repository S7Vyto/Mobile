//
//  SVCalendarComponents.swift
//  SVCalendarView
//
//  Created by Semyon Vyatkin on 23/10/2016.
//  Copyright © 2016 Semyon Vyatkin. All rights reserved.
//

import Foundation
import UIKit

public let SVCalendarComponentTag = 1001001

enum SVCalendarComponents {
    case defaultLabel(with: String)
    case cellLabel(with: String)
    
    func value() -> Any {
        switch self {
        case let .defaultLabel(title):
            let label = UILabel(frame: CGRect.zero)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textColor = UIColor.black
            label.text = title
            
            return label
            
        case let .cellLabel(title):
            let label = SVCalendarComponents.defaultLabel(with: title).value() as! UILabel
            label.tag = SVCalendarComponentTag
            label.textAlignment = .center
            label.contentMode = .center
            
            return label
        }
    }
}
