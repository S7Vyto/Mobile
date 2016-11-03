//
//  SVCalendarViewController.swift
//  SVCalendarView
//
//  Created by Semyon Vyatkin on 18/10/2016.
//  Copyright © 2016 Semyon Vyatkin. All rights reserved.
//

import UIKit

class SVCalendarViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
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
    
    fileprivate func configCalendarView() {
        calendarLayout.isAutoResizeCell = false
        calendarLayout.columnWidth = 85
        calendarLayout.columnHeight = 85
        calendarLayout.cellPadding = 0
        
        calendarCollectionView.layer.backgroundColor = UIColor.lightGray.cgColor
        calendarCollectionView.dataSource = self
        calendarCollectionView.delegate = self
        calendarCollectionView.collectionViewLayout = calendarLayout
        calendarCollectionView.register(UINib(nibName: SVCalendarViewCell.identifier, bundle: Bundle.main), forCellWithReuseIdentifier: SVCalendarViewCell.identifier)
    }
    
    fileprivate func configCalendarSwitcher() {
        
    }
    
    // MARK: - Calendar Switcher
    
    // MARK: - Collection DataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return calendarService.dates(for: .quarter).count
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SVCalendarViewCell.identifier, for: indexPath) as! SVCalendarViewCell
        let model = calendarService.dates(for: .quarter)[indexPath.item]
        
        cell.configCell(with: model)
        
        return cell
    }
 
    // MARK: - Collection Delegate
}
