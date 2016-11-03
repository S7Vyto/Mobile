//
//  SVCalendarViewCell.swift
//  SVCalendarView
//
//  Created by Sam on 18/10/2016.
//  Copyright © 2016 Semyon Vyatkin. All rights reserved.
//

import UIKit

class SVCalendarViewCell: UICollectionViewCell {
    fileprivate var model: SVCalendarDate!
    
    class var identifier: String {
        return NSStringFromClass(SVCalendarViewCell.self).replacingOccurrences(of: "SVCalendarView.", with: "")
    }
    
    // MARK: - Cell LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        configAppearance()
    }
    
    func configCell(with model: SVCalendarDate) {
        clearCellContent()
        self.model = model
        
        switch model.type {
        case SVCalendarType.day:
            configDayCell()
            break
        case SVCalendarType.week:
            configWeekCell()
            break
        case SVCalendarType.month:
            configMonthCell()
            break
        case SVCalendarType.quarter:
            configQuarterCell()
            break
        case SVCalendarType.year:
            configYearCell()
            break
        default:
            break
        }
    }
    
    // MARK: - Configurate Appearance
    fileprivate func clearCellContent() {
        for view in self.contentView.subviews {
            view.removeFromSuperview()
        }
    }
    
    fileprivate func configAppearance() {
        self.layer.backgroundColor = UIColor.purple.cgColor
    }

    fileprivate func configDayCell() {
        
    }
    
    fileprivate func configWeekCell() {
        
    }
    
    fileprivate func configMonthCell() {
       let valueLabel = SVCalendarComponents.cellLabel(with: model.title).value() as! UILabel
        
        self.contentView.addSubview(valueLabel)
        self.contentView.bringSubview(toFront: valueLabel)
        
        let vertConst = NSLayoutConstraint.constraints(withVisualFormat: "V:|-2-[valueLabel]-2-|", options: [], metrics: nil, views: ["valueLabel" : valueLabel])
        let horizConst = NSLayoutConstraint.constraints(withVisualFormat: "H:|-2-[valueLabel]-2-|", options: [], metrics: nil, views: ["valueLabel" : valueLabel])
        
        self.contentView.addConstraints(vertConst)
        self.contentView.addConstraints(horizConst)
    }
    
    fileprivate func configQuarterCell() {
        let valueLabel = SVCalendarComponents.cellLabel(with: model.title).value() as! UILabel
        
        self.contentView.addSubview(valueLabel)
        self.contentView.bringSubview(toFront: valueLabel)
        
        let vertConst = NSLayoutConstraint.constraints(withVisualFormat: "V:|-2-[valueLabel]-2-|", options: [], metrics: nil, views: ["valueLabel" : valueLabel])
        let horizConst = NSLayoutConstraint.constraints(withVisualFormat: "H:|-2-[valueLabel]-2-|", options: [], metrics: nil, views: ["valueLabel" : valueLabel])
        
        self.contentView.addConstraints(vertConst)
        self.contentView.addConstraints(horizConst)
    }
    
    fileprivate func configYearCell() {
        let valueLabel = SVCalendarComponents.cellLabel(with: model.title).value() as! UILabel
        
        self.contentView.addSubview(valueLabel)
        self.contentView.bringSubview(toFront: valueLabel)
        
        let vertConst = NSLayoutConstraint.constraints(withVisualFormat: "V:|-2-[valueLabel]-2-|", options: [], metrics: nil, views: ["valueLabel" : valueLabel])
        let horizConst = NSLayoutConstraint.constraints(withVisualFormat: "H:|-2-[valueLabel]-2-|", options: [], metrics: nil, views: ["valueLabel" : valueLabel])
        
        self.contentView.addConstraints(vertConst)
        self.contentView.addConstraints(horizConst)
    }
}
