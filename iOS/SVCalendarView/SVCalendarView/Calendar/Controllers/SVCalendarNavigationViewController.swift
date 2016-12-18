//
//  SVCalendarNavigationViewController.swift
//  SVCalendarView
//
//  Created by Sam on 19/11/2016.
//  Copyright © 2016 Semyon Vyatkin. All rights reserved.
//

import UIKit

enum SVCalendarNavigationDirection {
    case reduce, increase
}

class SVCalendarNavigationViewController: UIViewController {
    @IBOutlet weak var reduceButton: UIButton!
    @IBOutlet weak var increaseButton: UIButton!
    @IBOutlet weak var dateTitle: UILabel! {
        didSet {
            dateTitle.textColor = self.style.text.normalColor
            dateTitle.font = self.style.text.font
        }
    }
    
    static var identifier: String {
        return NSStringFromClass(SVCalendarNavigationViewController.self).replacingOccurrences(of: "SVCalendarView.", with: "")
    }
    
    static var controller: SVCalendarNavigationViewController {
        return SVCalendarNavigationViewController(nibName: SVCalendarNavigationViewController.identifier,
                                                  bundle: Bundle.main)
    }
    
    fileprivate let style = SVCalendarConfiguration.shared.styles.navigation
    weak var delegate: SVCalendarNavigationDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configApperance()
    }

    override func didReceiveMemoryWarning() {
        self.clearData()
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        self.clearData()
    }
    
    // MARK: - Config Appearance
    fileprivate func configApperance() {
        self.automaticallyAdjustsScrollViewInsets = false
        self.edgesForExtendedLayout = []
        
        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.backgroundColor = self.style.background.normalColor
    }
    
    // MARK: - Navigation Methods
    fileprivate func clearData() {
        self.delegate = nil
    }
    
    // MARK: - Navigation Delegates
    func configNavigationDate(_ date: String?) {
        self.dateTitle.text = date
    }
    
    @IBAction func didChangeNavigationDate(_ sender: UIButton) {
        guard let date = self.delegate?.didChangeNavigationDate(direction: sender.tag == 0 ? .reduce : .increase), date != "" else {
            return
        }
        
        self.configNavigationDate(date)
    }    
}
