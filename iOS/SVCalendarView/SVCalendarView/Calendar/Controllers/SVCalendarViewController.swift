//
//  SVCalendarViewController.swift
//  SVCalendarView
//
//  Created by Semyon Vyatkin on 18/10/2016.
//  Copyright © 2016 Semyon Vyatkin. All rights reserved.
//

import UIKit

class SVCalendarViewController: UIViewController, SVCalendarSwitcherDelegate, SVCalendarNavigationDelegate {
    @IBOutlet weak fileprivate var calendarCollectionView: UICollectionView!
    
    fileprivate let service = SVCalendarService(types: SVCalendarConfiguration.shared.types)
    fileprivate let layout = SVCalendarFlowLayout(direction: SVCalendarFlowLayoutDirection.vertical)
    fileprivate let config = SVCalendarConfiguration.shared
    
    fileprivate let containerStyle = SVCalendarConfiguration.shared.styles.container
    fileprivate let calendarStyle = SVCalendarConfiguration.shared.styles.calendar
    
    var dates = [SVCalendarDate]()
    var headerTitles = [String]()
    
    weak var delegate: SVCalendarDelegate?

    // MARK: - Controller LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configAppearance()
    }

    override func didReceiveMemoryWarning() {
        clearData()
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        clearData()
    }
    
    // MARK: - Configurate Appearance
    fileprivate func configAppearance() {
        configParentView()
        configCalendarView()
        configCalendarSwitcher()
        configCalendarNavigation()
    }
    
    fileprivate func configParentView() {
        self.automaticallyAdjustsScrollViewInsets = false
        self.edgesForExtendedLayout = []
        
        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.backgroundColor = containerStyle.background.normalColor
    }
    
    fileprivate func configCalendarLayout(for type: SVCalendarType) {
        layout.clear()
        layout.isHeader1Visible = config.isHeaderSection1Visible
        layout.isHeader2Visible = config.isHeaderSection2Visible
        layout.isTimeVisible = config.isTimeSectionVisible
        
        layout.isAutoResizeCell = true
        layout.cellPadding = 0
        
        switch type {
        case SVCalendarType.day:
            layout.columnHeight = 45
            
            layout.numberOfColumns = 1
            layout.numberOfRows = 25
            break
            
        case SVCalendarType.week:
            layout.columnHeight = 45
            
            layout.numberOfColumns = 7
            layout.numberOfRows = 25
            break
            
        case SVCalendarType.month:
            layout.isHeader2Visible = false
            layout.isTimeVisible = false
            
            layout.numberOfColumns = 7
            layout.numberOfRows = 6
            break
            
        case SVCalendarType.quarter:
            break
            
        case SVCalendarType.year:
            break
            
        default:
            break
        }
        
        layout.update()
    }
    
    fileprivate func configCalendarView() {
        updateCalendarData(for: .month)
        configCalendarLayout(for: .month)
        
        calendarCollectionView.backgroundColor = calendarStyle.background.normalColor
        calendarCollectionView.dataSource = self
        calendarCollectionView.delegate = self
        calendarCollectionView.collectionViewLayout = layout
        calendarCollectionView.register(UINib(nibName: SVCalendarViewCell.identifier, bundle: Bundle.main),
                                        forCellWithReuseIdentifier: SVCalendarViewCell.identifier)
        
        if config.isHeaderSection1Visible {
            calendarCollectionView.register(UINib(nibName: SVCalendarHeaderView.identifier, bundle: Bundle.main),
                                            forSupplementaryViewOfKind: SVCalendarHeaderSection1,
                                            withReuseIdentifier: SVCalendarHeaderView.identifier)
        }
        
        if config.isHeaderSection2Visible {
            calendarCollectionView.register(UINib(nibName: SVCalendarHeaderView.identifier, bundle: Bundle.main),
                                            forSupplementaryViewOfKind: SVCalendarHeaderSection2,
                                            withReuseIdentifier: SVCalendarHeaderView.identifier)
        }
        
        if config.isTimeSectionVisible {
            calendarCollectionView.register(UINib(nibName: SVCalendarTimeView.identifier, bundle: Bundle.main),
                                            forSupplementaryViewOfKind: SVCalendarTimeSection,
                                            withReuseIdentifier: SVCalendarTimeView.identifier)
        }
    }
    
    fileprivate func configCalendarSwitcher() {
        if config.isSwitcherVisible && config.types.count > 1 {
            let switcher = SVCalendarSwitcherViewController(types: config.types)
            switcher.delegate = self
            switcher.selectedIndex = 0
            
            self.addChildViewController(switcher)
            self.view.addSubview(switcher.view)
            switcher.didMove(toParentViewController: self)
            
            let topConst = NSLayoutConstraint(item: switcher.view, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 5.0)
            let leadingConst = NSLayoutConstraint(item: switcher.view, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 0.0)
            let trailingConst = NSLayoutConstraint(item: self.view, attribute: .trailing, relatedBy: .equal, toItem: switcher.view, attribute: .trailing, multiplier: 1.0, constant: 0.0)
            let heightConst = NSLayoutConstraint(item: switcher.view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 35.0)
            
            self.view.addConstraints([topConst, leadingConst, trailingConst, heightConst])
            self.updateCalendarCollectioViewConstraints(anchor: switcher.view)
        }
    }
    
    fileprivate func configCalendarNavigation() {
        if config.isNavigationVisible {
            let navigation = SVCalendarNavigationViewController.controller
            navigation.delegate = self
            
            self.addChildViewController(navigation)
            self.view.addSubview(navigation.view)
            navigation.didMove(toParentViewController: self)
            
            let viewName = "navigationView"
            let bindingViews = [
                viewName: navigation.view
            ] as [String : Any]
            
            let vertConst = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[\(viewName)(45)]", options: [], metrics: nil, views: bindingViews)
            let horizConst = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[\(viewName)]-0-|", options: [], metrics: nil, views: bindingViews)
            
            self.view.addConstraints(vertConst)
            self.view.addConstraints(horizConst)
            
            navigation.configNavigationDate(service.updatedDate.convertWith(format: SVCalendarDateFormat.monthYear))
        }
    }
    
    // MARK: - Calendar Methods
    fileprivate func clearData() {
        dates.removeAll()
        headerTitles.removeAll()
    }
    
    fileprivate func updateCalendarData(for type: SVCalendarType) {
        clearData()
        
        dates = service.dates(for: type)
        headerTitles = service.titles(for: type)
    }
    
    fileprivate func updateCalendarCollectioViewConstraints(anchor: UIView?) {
        for constraint in self.view.constraints {
            if constraint.identifier == "CalendarContentTopConstraint" {
                self.view.removeConstraint(constraint)
                break
            }
        }
        
        if anchor != nil {
            self.view.addConstraint(NSLayoutConstraint(item: calendarCollectionView, attribute: .top, relatedBy: .equal, toItem: anchor, attribute: .bottom, multiplier: 1.0, constant: 0.0))
        }
    }
    
    // MARK: - Calendar Switcher
    func didSelectType(_ type: SVCalendarType) {
        updateCalendarData(for: type)
        configCalendarLayout(for: type)
        
        calendarCollectionView.reloadData()
    }
    
    // MARK: - Calendar Navigation
    func didChangeNavigationDate(direction: SVCalendarNavigationDirection) -> String? {
        if direction == .reduce {
            service.updateDate(for: .month, isDateIncrease: false)
        }
        else if direction == .increase {
            service.updateDate(for: .month, isDateIncrease: true)
        }
        
        configCalendarLayout(for: .month)
        updateCalendarData(for: .month)
        
        calendarCollectionView.reloadData()
        
        return service.updatedDate.convertWith(format: SVCalendarDateFormat.monthYear)
    }
}
