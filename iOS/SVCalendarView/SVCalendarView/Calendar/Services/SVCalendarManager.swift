//
//  SVCalendarManger.swift
//  SVCalendarView
//
//  Created by Semyon Vyatkin on 19/10/2016.
//  Copyright © 2016 Semyon Vyatkin. All rights reserved.
//

import Foundation
import UIKit

/**
 Calendar Manager
 This class help easy set up calendar by default
 */

public class SVCalendarManager {
    class var calendarIndetifier: String {
        return NSStringFromClass(SVCalendarViewController.self).replacingOccurrences(of: "SVCalendarView.", with: "")
    }
    
    static var calendarController: SVCalendarViewController {
        return SVCalendarViewController(nibName: calendarIndetifier, bundle: Bundle.main)
    }
    
    static func addCalendarTo(parentController: UIViewController, withConstraints constraints: [NSLayoutConstraint]?) -> SVCalendarViewController {
        let calendar = calendarController
        
        parentController.addChildViewController(calendar)
        parentController.view.addSubview(calendar.view)
        calendar.didMove(toParentViewController: parentController)
        
        guard constraints != nil else {
            let vc = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[calendar]-0-|", options: [], metrics: nil, views: ["calendar": calendar.view])
            let hc = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[calendar]-0-|", options: [], metrics: nil, views: ["calendar": calendar.view])
            
            parentController.view.addConstraints(vc)
            parentController.view.addConstraints(hc)
            
            return calendar
        }
        
        parentController.view.addConstraints(constraints!)
        return calendar
    }
}
