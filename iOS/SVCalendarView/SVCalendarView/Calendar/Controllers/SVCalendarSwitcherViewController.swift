//
//  SVCalendarSwitcherViewController.swift
//  SVCalendarView
//
//  Created by Sam on 20/10/2016.
//  Copyright © 2016 Semyon Vyatkin. All rights reserved.
//

import UIKit

protocol SVCalendarSwitcherDelegate: class {
    func didSelectType(_ type: SVCalendarType)
}

class SVCalendarSwitcherViewController: UIViewController {
    fileprivate lazy var stackViewContainer: UIStackView = {
        let control = UIStackView(frame: CGRect.zero)
        control.translatesAutoresizingMaskIntoConstraints = false
        control.alignment = .fill
        control.axis = .horizontal
        control.spacing = 1.0
        control.distribution = .fillEqually
        
        return control
    }()
    
    fileprivate let types: [SVCalendarType]
    fileprivate let style = SVCalendarConfiguration.shared.styles.switcher
    
    weak var delegate: SVCalendarSwitcherDelegate?
    var selectedIndex = 0 {
        didSet {
            
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
        configStackViewContainer()
        configStackViewContent()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Configurate Appearance
    fileprivate func configAppearance() {
        self.edgesForExtendedLayout = []
        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.backgroundColor = style.background.normalColor
    }
    
    fileprivate func configStackViewContainer() {
        self.view.addSubview(stackViewContainer)
        self.view.bringSubview(toFront: stackViewContainer)
        
        let bindingViews = [
            "stackViewContainer" : stackViewContainer
        ]
        
        let vertConst = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[stackViewContainer]-0-|", options: [], metrics: nil, views: bindingViews)
        let horizConst = NSLayoutConstraint.constraints(withVisualFormat: "H:|-2-[stackViewContainer]-2-|", options: [], metrics: nil, views: bindingViews)
        
        self.view.addConstraints(vertConst)
        self.view.addConstraints(horizConst)
    }
    
    fileprivate func configStackViewContent() {
        var index = 0
        for type in types {
            var title = ""
            
            switch type {
            case SVCalendarType.day:
                title = "DAY"
                break
            
            case SVCalendarType.week:
                title = "WEEK"
                break
                
            case SVCalendarType.month:
                title = "MONTH"
                break
                
            case SVCalendarType.quarter:
                title = "QUARTER"
                break
                
            case SVCalendarType.year:
                title = "YEAR"
                break
                
            default:
                break
            }
            
            let switcher = SVCalendarComponents.switcherButton(with: title).value() as! UIButton
            switcher.tag = index
            switcher.isSelected = index == 0
            switcher.addTarget(self, action: #selector(didChangeValue(_:)), for: .touchUpInside)
            
            stackViewContainer.addArrangedSubview(switcher)
            index += 1
        }
    }    
    
    // MARK: - Switcher Methods
    func didChangeValue(_ sender: UIButton) {
        selectSwitcherButton(sender)
        
        var type: SVCalendarType
        switch sender.tag {
        case 0:
            type = .day
            break
            
        case 1:
            type = .week
            break
            
        case 2:
            type = .month
            break
            
        case 3:
            type = .quarter
            break
            
        case 4:
            type = .year
            break
            
        default:
            type = .month
            break
        }
        
        delegate?.didSelectType(type)
    }
    
    fileprivate func selectSwitcherButton(_ selectedButton: UIButton) {
        for unselectedButton in stackViewContainer.arrangedSubviews as! [UIButton] {
            unselectedButton.isSelected = unselectedButton.tag == selectedButton.tag
        }
    }
}
