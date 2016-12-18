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
    static let style = SVCalendarConfiguration.shared.styles.cell
    
    static var identifier: String {
        return NSStringFromClass(SVCalendarViewCell.self).replacingOccurrences(of: "SVCalendarView.", with: "")
    }
    
    lazy var selectionLayer: CAShapeLayer = {
        let circleLayer = CAShapeLayer()
        circleLayer.fillColor = SVCalendarViewCell.style.layer.normalColor?.cgColor
        circleLayer.strokeColor = SVCalendarViewCell.style.layer.selectedColor?.cgColor
        
        return circleLayer
    }()
    
    override var bounds: CGRect {
        didSet {
            self.contentView.frame = self.bounds
        }
    }

    override var isSelected: Bool {
        didSet {
            selectionLayer.isHidden = !isSelected            
        }
    }
    
    // MARK: - Cell LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        configAppearance()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let selectionWidth = min(self.bounds.size.width, self.bounds.size.height) * 0.75
        let selectionX = (self.bounds.size.width - selectionWidth) * 0.5
        let selectionY = (self.bounds.size.height - selectionWidth) * 0.5
        let selectionRect = CGRect(x: selectionX, y: selectionY, width: selectionWidth, height: selectionWidth)
        
        selectionLayer.frame = self.bounds
        selectionLayer.path = UIBezierPath(roundedRect: selectionRect, cornerRadius: selectionRect.size.width * 0.5).cgPath
    }
    
    func configCell(with model: SVCalendarDate) {
        self.model = model
        
        switch model.type {
        case SVCalendarType.day: configDayCell()
        case SVCalendarType.week: configWeekCell()
        case SVCalendarType.month: configMonthCell()
        case SVCalendarType.quarter: configQuarterCell()
        case SVCalendarType.year: configYearCell()
        default: break
        }
    }
    
    // MARK: - Configurate Appearance
    fileprivate func clearCellContent() {
        for view in self.contentView.subviews {
            view.removeFromSuperview()
        }
    }
    
    fileprivate func configAppearance() {
        self.layer.backgroundColor = SVCalendarViewCell.style.button.normalColor?.cgColor
            
        self.contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.contentView.autoresizesSubviews = true
        
        self.contentView.layer.addSublayer(selectionLayer)
    }

    fileprivate func configValueLabel() {
        var valueLabel = self.contentView.viewWithTag(SVCalendarComponentTag) as? UILabel
        if valueLabel == nil {
            valueLabel = SVCalendarComponents.cellLabel(with: self.model.title).value() as? UILabel
            self.contentView.addSubview(valueLabel!)
            
            let nameView = "valueLabel"
            let bindigViews = [
                nameView: valueLabel!
                ] as [String: Any]
            
            let vertConst = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[\(nameView)]-0-|", options: [], metrics: nil, views:bindigViews)
            let horizConst = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[\(nameView)]-0-|", options: [], metrics: nil, views: bindigViews)
            
            self.contentView.addConstraints(vertConst)
            self.contentView.addConstraints(horizConst)
            
        }
        
        valueLabel?.textColor = SVCalendarViewCell.style.text.normalColor
        valueLabel?.text = self.model.title
        valueLabel?.font = SVCalendarViewCell.style.text.font
        
        if !self.model.isEnabled {
            valueLabel?.textColor = SVCalendarViewCell.style.text.disabledColor
        }
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
