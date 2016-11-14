//
//  SVColorExtension.swift
//  SVCalendarView
//
//  Created by Sam on 12/11/2016.
//  Copyright © 2016 Semyon Vyatkin. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    static func rgb(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat) -> UIColor {
        return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }
}
