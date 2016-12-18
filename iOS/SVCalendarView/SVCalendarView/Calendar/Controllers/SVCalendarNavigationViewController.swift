//
//  SVCalendarNavigationViewController.swift
//  SVCalendarView
//
//  Created by Sam on 19/11/2016.
//  Copyright © 2016 Semyon Vyatkin. All rights reserved.
//

import UIKit

class SVCalendarNavigationViewController: UIViewController {
    @IBOutlet weak var reduceButton: UIButton!
    @IBOutlet weak var increaseButton: UIButton!
    @IBOutlet weak var dateTitle: UILabel!
    
    static var identifier: String {
        return NSStringFromClass(SVCalendarNavigationViewController.self).replacingOccurrences(of: "SVCalendarView.", with: "")
    }
    
    static var controller: SVCalendarNavigationViewController {
        return SVCalendarNavigationViewController(nibName: SVCalendarNavigationViewController.identifier,
                                                  bundle: Bundle.main)
    }
    
    weak var delegate: SVCalendarNavigationDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        configApperance()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Config Appearance
    fileprivate func configApperance() {
        self.automaticallyAdjustsScrollViewInsets = false
        self.edgesForExtendedLayout = []
        
        self.view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: - Navigation Methods
    @IBAction func didChangeNavigationDate(_ sender: UIButton) {
        
    }    
}
