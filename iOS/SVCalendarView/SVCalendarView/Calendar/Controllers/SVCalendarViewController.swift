//
//  SVCalendarViewController.swift
//  SVCalendarView
//
//  Created by Semyon Vyatkin on 18/10/2016.
//  Copyright © 2016 Semyon Vyatkin. All rights reserved.
//

import UIKit

class SVCalendarViewController: UIViewController, SVCalendarSwitcherDelegate, SVCalendarNavigationDelegate {
    lazy var calendarView: UICollectionView = {
        let flowLayout = SVCalendarFlowLayout(direction: SVCalendarFlowLayoutDirection.vertical)
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
    }()
    
    fileprivate var flowLayout: SVCalendarFlowLayout!
    fileprivate let service = SVCalendarService(types: SVCalendarConfiguration.shared.types)
    fileprivate let config = SVCalendarConfiguration.shared
    
    fileprivate let containerStyle = SVCalendarConfiguration.shared.styles.container
    fileprivate let calendarStyle = SVCalendarConfiguration.shared.styles.calendar
    
    fileprivate var switcherView: SVCalendarSwitcherView?
    fileprivate var navigationView: SVCalendarNavigationView!
    
    var dates = [SVCalendarDate]()
    var headerTitles = [String]()
    
    weak var delegate: SVCalendarDelegate?
    var selectedDate: Date?

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
        self.configParentView()
        self.configCalendarSwitcher()
        self.configCalendarNavigation()
        self.configCalendarView()
        self.updateCalendarConstraints()
    }
    
    fileprivate func configParentView() {        
        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.backgroundColor = containerStyle.background.normalColor
    }
    
    fileprivate func configCalendarLayout(for type: SVCalendarType) {
        self.flowLayout.clear()
        
        self.flowLayout.isHeader1Visible = config.isHeaderSection1Visible
        self.flowLayout.isHeader2Visible = config.isHeaderSection2Visible
        self.flowLayout.isTimeVisible = config.isTimeSectionVisible
        
        self.flowLayout.isAutoResizeCell = true
        self.flowLayout.cellPadding = 0
        
        switch type {
        case SVCalendarType.day:
            self.flowLayout.columnHeight = 45
            
            self.flowLayout.numberOfColumns = 1
            self.flowLayout.numberOfRows = 25
            break
            
        case SVCalendarType.week:
            self.flowLayout.columnHeight = 45
            
            self.flowLayout.numberOfColumns = 7
            self.flowLayout.numberOfRows = 25
            break
            
        case SVCalendarType.month:
            self.flowLayout.isHeader2Visible = false
            self.flowLayout.isTimeVisible = false
            
            self.flowLayout.numberOfColumns = 7
            self.flowLayout.numberOfRows = 6
            break
            
        case SVCalendarType.quarter:
            break
            
        case SVCalendarType.year:
            break
            
        default:
            break
        }
        
        self.flowLayout.update()
    }
    
    fileprivate func configCalendarView() {
        self.flowLayout = self.calendarView.collectionViewLayout as! SVCalendarFlowLayout
        
        self.calendarView.backgroundColor = calendarStyle.background.normalColor
        self.calendarView.register(UINib(nibName: SVCalendarViewBaseCell.identifier, bundle: Bundle.main),
                                        forCellWithReuseIdentifier: SVCalendarViewBaseCell.identifier)
        
        if self.config.isHeaderSection1Visible {
            self.calendarView.register(UINib(nibName: SVCalendarHeaderView.identifier, bundle: Bundle.main),
                                       forSupplementaryViewOfKind: SVCalendarHeaderSection1,
                                       withReuseIdentifier: SVCalendarHeaderView.identifier)
        }
        
        if self.config.isHeaderSection2Visible {
            self.calendarView.register(UINib(nibName: SVCalendarHeaderView.identifier, bundle: Bundle.main),
                                       forSupplementaryViewOfKind: SVCalendarHeaderSection2,
                                       withReuseIdentifier: SVCalendarHeaderView.identifier)
        }
        
        if self.config.isTimeSectionVisible {
            self.calendarView.register(UINib(nibName: SVCalendarTimeView.identifier, bundle: Bundle.main),
                                       forSupplementaryViewOfKind: SVCalendarTimeSection,
                                       withReuseIdentifier: SVCalendarTimeView.identifier)
        }
        
        self.view.addSubview(self.calendarView)
        
        self.updateCalendarData(for: .month)
        self.configCalendarLayout(for: .month)
    }
    
    fileprivate func configCalendarSwitcher() {
        if self.config.isSwitcherVisible {
            self.switcherView = SVCalendarSwitcherView(types: config.types,
                                                       delegate: self)
            
            self.view.addSubview(self.switcherView!)
        }
    }
    
    fileprivate func configCalendarNavigation() {
        if self.config.isNavigationVisible {
            self.navigationView = SVCalendarNavigationView.navigation(delegate: self,
                                                                      title: self.service.updatedDate.convertWith(format: SVCalendarDateFormat.monthYear))
            self.view.addSubview(self.navigationView)
        }
    }
    
    // MARK: - Calendar Methods
    fileprivate func clearData() {
        dates.removeAll()
        headerTitles.removeAll()
    }
    
    fileprivate func updateCalendarData(for type: SVCalendarType) {
        self.clearData()
        
        self.dates = service.dates(for: type)
        self.headerTitles = service.titles(for: type)
    }
    
    fileprivate func updateCalendarConstraints() {
        var calendarViewTopConst: NSLayoutConstraint?
        var navigationViewTopConst: NSLayoutConstraint?
        
        var constraints = [
            NSLayoutConstraint.leadingConst(item: self.calendarView, toItem: self.view, value: 0.0),
            NSLayoutConstraint.trailingConst(item: self.calendarView, toItem: self.view, value: 0.0),
            NSLayoutConstraint.bottomConst(item: self.calendarView, toItem: self.view, value: 0.0)
        ]
        
        if self.config.isNavigationVisible {
            constraints += [
                NSLayoutConstraint.leadingConst(item: self.navigationView!, toItem: self.view, value: 5.0),
                NSLayoutConstraint.trailingConst(item: self.navigationView!, toItem: self.view, value: 5.0),
                NSLayoutConstraint.heightConst(item: self.navigationView!, value: 45.0)
            ]
            
            calendarViewTopConst = NSLayoutConstraint.topConstAfter(item: self.navigationView!,
                                                                    toItem: self.calendarView,
                                                                    value: 0)
            
            navigationViewTopConst = NSLayoutConstraint.topConst(item: self.navigationView!,
                                                                 toItem: self.view,
                                                                 value: 5.0)
        }
        
        if self.config.isSwitcherVisible {
            constraints += [
                NSLayoutConstraint.topConst(item: self.switcherView!, toItem: self.view, value: 5.0),
                NSLayoutConstraint.leadingConst(item: self.switcherView!, toItem: self.view, value: 5.0),
                NSLayoutConstraint.trailingConst(item: self.switcherView!, toItem: self.view, value: 5.0),
                NSLayoutConstraint.heightConst(item: self.switcherView!, value: 45.0)
            ]
            
            if calendarViewTopConst == nil {
                calendarViewTopConst = NSLayoutConstraint.topConstAfter(item: self.switcherView!,
                                                                        toItem: self.calendarView,
                                                                        value: 5.0)
            }
            else {
                navigationViewTopConst = NSLayoutConstraint.topConstAfter(item: self.switcherView!,
                                                                          toItem: self.navigationView!,
                                                                          value: 5.0)
            }
        }
        
        if calendarViewTopConst == nil {
            calendarViewTopConst = NSLayoutConstraint.topConst(item: self.calendarView,
                                                               toItem: self.view,
                                                               value: 0.0)
        }
        
        self.view.addConstraints(constraints)
        
        if calendarViewTopConst != nil {
            self.view.addConstraint(calendarViewTopConst!)
        }
        
        if navigationViewTopConst != nil {
            self.view.addConstraint(navigationViewTopConst!)
        }
    }
    
    // MARK: - Calendar Switcher
    func didSelectType(_ type: SVCalendarType) {
        self.updateCalendarData(for: type)
        self.configCalendarLayout(for: type)
        
        self.calendarView.reloadData()
    }
    
    // MARK: - Calendar Navigation
    func didChangeNavigationDate(direction: SVCalendarNavigationDirection) -> String? {
        if direction == .reduce {
            self.service.updateDate(for: .month, isDateIncrease: false)
        }
        else if direction == .increase {
            self.service.updateDate(for: .month, isDateIncrease: true)
        }
        
        self.configCalendarLayout(for: .month)
        self.updateCalendarData(for: .month)
        
        self.calendarView.reloadData()
        
        return self.service.updatedDate.convertWith(format: SVCalendarDateFormat.monthYear)
    }
}
