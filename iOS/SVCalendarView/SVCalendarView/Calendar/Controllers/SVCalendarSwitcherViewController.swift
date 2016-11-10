//
//  SVCalendarSwitcherViewController.swift
//  SVCalendarView
//
//  Created by Sam on 20/10/2016.
//  Copyright © 2016 Semyon Vyatkin. All rights reserved.
//

import UIKit

protocol SVCalendarSwitcherDelegate: class {
    func didSelectSectionWithType(_ type: SVCalendarType)
}

class SVCalendarSwitcherViewController: UIViewController {
    fileprivate lazy var calendarSegmentControl: UISegmentedControl = {
        let segment = UISegmentedControl(frame: CGRect.zero)
        segment.translatesAutoresizingMaskIntoConstraints = false
        
        return segment
    }()
    
    fileprivate let types: [SVCalendarType]
    
    weak var delegate: SVCalendarSwitcherDelegate?
    var selectedIndex = 0 {
        didSet {
            calendarSegmentControl.selectedSegmentIndex = selectedIndex
        }
    }
    
    // MARK: - Controller LifeCycle
    init(types: [SVCalendarType]) {
        self.types = types
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configAppearance()
        configCalendarSegment()
        configCalendarSegmentContent()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Configurate Appearance
    fileprivate func configAppearance() {
        self.edgesForExtendedLayout = []
        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.backgroundColor = UIColor.purple        
    }
    
    fileprivate func configCalendarSegment() {
        self.view.addSubview(calendarSegmentControl)
        self.view.bringSubview(toFront: calendarSegmentControl)
        
        let bindingViews = [
            "calendarSegmentControl" : calendarSegmentControl
        ]
        
        let vertConst = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[calendarSegmentControl]-0-|", options: [], metrics: nil, views: bindingViews)
        let horizConst = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[calendarSegmentControl]-0-|", options: [], metrics: nil, views: bindingViews)
        
        self.view.addConstraints(vertConst)
        self.view.addConstraints(horizConst)
    }
    
    fileprivate func configCalendarSegmentContent() {
        var index = 0
        for type in types {
            var title = ""
            
            switch type {
            case SVCalendarType.day:
                title = "День"
                break
            
            case SVCalendarType.week:
                title = "Неделя"
                break
                
            case SVCalendarType.month:
                title = "Месяц"
                break
                
            case SVCalendarType.quarter:
                title = "Квартал"
                break
                
            case SVCalendarType.year:
                title = "Год"
                break
                
            default:
                break
            }
            
            calendarSegmentControl.insertSegment(withTitle: title, at: index, animated: true)
            index += 1
        }
    }
}
