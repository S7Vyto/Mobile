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
    
    fileprivate let calendarService = SVCalendarService(types: SVCalendarConfiguration.shared.types)
    fileprivate let calendarLayout = SVCalendarFlowLayout(direction: SVCalendarFlowLayoutDirection.vertical)
    fileprivate let calendarConfig = SVCalendarConfiguration.shared
    fileprivate let calendarStyle = SVCalendarStyle.classic

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
        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.edgesForExtendedLayout = []
    }
    
    fileprivate func configCalendarLayout(for type: SVCalendarType) {
        calendarLayout.isHeader1Visible = calendarConfig.isHeaderSection1Visible
        calendarLayout.isHeader2Visible = calendarConfig.isHeaderSection2Visible
        calendarLayout.isTimeVisible = calendarConfig.isTimeSectionVisible
        
        calendarLayout.isAutoResizeCell = true
        calendarLayout.cellPadding = 0
        
        switch type {
        case SVCalendarType.day:
            calendarLayout.columnHeight = 45
            
            calendarLayout.numberOfColumns = 1
            calendarLayout.numberOfRows = 25
            break
            
        case SVCalendarType.week:
            calendarLayout.columnHeight = 45
            
            calendarLayout.numberOfColumns = 7
            calendarLayout.numberOfRows = 25
            break
            
        case SVCalendarType.month:
            calendarLayout.isHeader2Visible = false
            calendarLayout.isTimeVisible = false
            
            calendarLayout.numberOfColumns = 7
            calendarLayout.numberOfRows = 6
            break
            
        case SVCalendarType.quarter:
            break
            
        case SVCalendarType.year:
            break
            
        default:
            break
        }
    }
    
    fileprivate func configCalendarView() {
        configCalendarLayout(for: .month)
        
        calendarCollectionView.backgroundColor = UIColor.clear
        calendarCollectionView.dataSource = self
        calendarCollectionView.delegate = self
        calendarCollectionView.collectionViewLayout = calendarLayout
        calendarCollectionView.register(UINib(nibName: SVCalendarViewCell.identifier, bundle: Bundle.main),
                                        forCellWithReuseIdentifier: SVCalendarViewCell.identifier)
        
        if calendarConfig.isHeaderSection1Visible {
            calendarCollectionView.register(UINib(nibName: SVCalendarHeaderView.identifier, bundle: Bundle.main),
                                            forSupplementaryViewOfKind: SVCalendarHeaderSection1,
                                            withReuseIdentifier: SVCalendarHeaderView.identifier)
        }
        
        if calendarConfig.isHeaderSection2Visible {
            calendarCollectionView.register(UINib(nibName: SVCalendarHeaderView.identifier, bundle: Bundle.main),
                                            forSupplementaryViewOfKind: SVCalendarHeaderSection2,
                                            withReuseIdentifier: SVCalendarHeaderView.identifier)
        }
        
        if calendarConfig.isTimeSectionVisible {
            calendarCollectionView.register(UINib(nibName: SVCalendarTimeView.identifier, bundle: Bundle.main),
                                            forSupplementaryViewOfKind: SVCalendarTimeSection,
                                            withReuseIdentifier: SVCalendarTimeView.identifier)
        }
    }
    
    fileprivate func configCalendarSwitcher() {
        if calendarConfig.isSwitcherVisible {
            let switcher = SVCalendarSwitcherViewController(types: calendarConfig.types)
            switcher.delegate = self
            switcher.selectedIndex = 0
            
            self.addChildViewController(switcher)
            self.view.addSubview(switcher.view)
            switcher.didMove(toParentViewController: self)
            
            let topConst = NSLayoutConstraint(item: switcher.view, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 0.0)
            let leadingConst = NSLayoutConstraint(item: switcher.view, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 0.0)
            let trailingConst = NSLayoutConstraint(item: self.view, attribute: .trailing, relatedBy: .equal, toItem: switcher.view, attribute: .trailing, multiplier: 1.0, constant: 0.0)
            let heightConst = NSLayoutConstraint(item: switcher.view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 45.0)
            
            self.view.addConstraints([topConst, leadingConst, trailingConst, heightConst])
            self.updateCalendarCollectioViewConstraints(anchor: switcher.view)
        }
    }
    
    // MARK: - Calendar Methods
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
    func didSelectSectionWithType(_ type: SVCalendarType) {
        configCalendarLayout(for: type)
    }
    
    // MARK: - Collection DataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return calendarService.dates(for: .month).count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case SVCalendarHeaderSection1:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                             withReuseIdentifier: SVCalendarHeaderView.identifier,
                                                                             for: indexPath)
            
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
        let model = calendarService.dates(for: .month)[indexPath.item]
        
        cell.configCell(with: model)
        
        return cell
    }
 
    // MARK: - Collection Delegate
}
