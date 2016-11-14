//
//  SVCalendarViewController.swift
//  SVCalendarView
//
//  Created by Semyon Vyatkin on 18/10/2016.
//  Copyright © 2016 Semyon Vyatkin. All rights reserved.
//

import UIKit

class SVCalendarViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, SVCalendarSwitcherDelegate {
    @IBOutlet weak fileprivate var calendarCollectionView: UICollectionView!
    
    fileprivate let service = SVCalendarService(types: SVCalendarConfiguration.shared.types)
    fileprivate let layout = SVCalendarFlowLayout(direction: SVCalendarFlowLayoutDirection.vertical)
    fileprivate let config = SVCalendarConfiguration.shared
    
    fileprivate let containerStyle = SVCalendarConfiguration.shared.styles.container
    fileprivate let calendarStyle = SVCalendarConfiguration.shared.styles.calendar
    
    fileprivate var dates = [SVCalendarDate]()
    fileprivate var headerTitles = [String]()

    // MARK: - Controller LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configAppearance()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Configurate Appearance
    fileprivate func configAppearance() {
        configParentView()
        configCalendarView()
        configCalendarSwitcher()
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
        if config.isSwitcherVisible {
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
    
    // MARK: - Calendar Methods
    fileprivate func updateCalendarData(for type: SVCalendarType) {
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
    
    // MARK: - Collection DataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dates.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case SVCalendarHeaderSection1:
            let index = indexPath.item + 1
            var title: String?
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                             withReuseIdentifier: SVCalendarHeaderView.identifier,
                                                                             for: indexPath) as! SVCalendarHeaderView
            if headerTitles.count == 0 {
                title = "-"
            }
            else if index >= headerTitles.count {
                title = headerTitles[0]
            }
            else {
                title = headerTitles[index]
            }
            
            headerView.title = title
            
            return headerView
            
        case SVCalendarHeaderSection2:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                             withReuseIdentifier: SVCalendarHeaderView.identifier,
                                                                             for: indexPath)
            
            return headerView
            
        case SVCalendarTimeSection:
            let timeView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                           withReuseIdentifier: SVCalendarTimeView.identifier,
                                                                           for: indexPath)
            
            return timeView
            
        default:
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SVCalendarViewCell.identifier, for: indexPath) as! SVCalendarViewCell
        let model = dates[indexPath.item]
        
        cell.configCell(with: model)
        
        return cell
    }
 
    // MARK: - Collection Delegate
}
