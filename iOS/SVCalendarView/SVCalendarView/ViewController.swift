//
//  ViewController.swift
//  SVCalendarView
//
//  Created by Semyon Vyatkin on 18/10/2016.
//  Copyright © 2016 Semyon Vyatkin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    fileprivate var calendarController: SVCalendarViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        calendarController = SVCalendarManager.addCalendarTo(parentController: self, withConstraints: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

