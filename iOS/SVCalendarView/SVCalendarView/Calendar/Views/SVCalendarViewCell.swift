//
//  SVCalendarViewCell.swift
//  SVCalendarView
//
//  Created by Semyon Vyatkin on 18/10/2016.
//  Copyright © 2016 Semyon Vyatkin. All rights reserved.
//

import UIKit

class SVCalendarViewCell: UICollectionViewCell {    
    fileprivate var model: SVCalendarDate!
    
    class var identifier: String {
        return NSStringFromClass(SVCalendarViewCell.self).replacingOccurrences(of: "SVCalendarView.", with: "")
    }
    
    override var bounds: CGRect {
        didSet {
            self.contentView.frame = self.bounds
        }
    }
    
    // MARK: - Cell LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        configAppearance()
    }
    
    func configCell(with model: SVCalendarDate) {
//        clearCellContent()
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
        self.layer.backgroundColor = UIColor.lightGray.cgColor
        self.contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.contentView.autoresizesSubviews = true
    }

    fileprivate func configValueLabel() {
        guard let valueLabel = self.contentView.viewWithTag(SVCalendarComponentTag) as? UILabel else {
            let valueLabel = SVCalendarComponents.cellLabel(with: model.title).value() as! UILabel
            
            self.contentView.addSubview(valueLabel)
            
            let vertConst = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[valueLabel]-0-|", options: [], metrics: nil, views: ["valueLabel" : valueLabel])
            let horizConst = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[valueLabel]-0-|", options: [], metrics: nil, views: ["valueLabel" : valueLabel])
            
            self.contentView.addConstraints(vertConst)
            self.contentView.addConstraints(horizConst)
            
            return
        }
        
        valueLabel.text = model.title
    }
    
    fileprivate func configDayCell() {
        configValueLabel()
    }
    
    fileprivate func configWeekCell() {
        configValueLabel()
    }
    
    fileprivate func configMonthCell() {
       configValueLabel()
    }
    
    fileprivate func configQuarterCell() {
        configValueLabel()
    }
    
    fileprivate func configYearCell() {
        configValueLabel()
    }
}
