//
//  NewsletterTableViewCell.swift
//  SVNewsletter
//
//  Created by Sam on 22/11/2016.
//  Copyright © 2016 Semyon Vyatkin. All rights reserved.
//

import UIKit

class NewsletterTableViewCell: UITableViewCell {
    @IBOutlet weak private var descLabel: UILabel!
    
    static var identifier: String {
        return NSStringFromClass(self).replacingOccurrences(of: "SVNewsletter.", with: "")
    }
    
    override var bounds: CGRect {
        didSet {
            self.contentView.bounds = bounds
        }
    }
    
    var desc: String? {
        didSet {
            descLabel.text = desc
        }
    }
    
    private lazy var backgroundLayer: CAGradientLayer = {
        let bgLayer = CAGradientLayer()
        bgLayer.shouldRasterize = true
        bgLayer.rasterizationScale = UIScreen.main.scale
        bgLayer.isOpaque = true
        bgLayer.opacity = 0.08
        bgLayer.masksToBounds = true
        bgLayer.cornerRadius = 4.0
        
        bgLayer.shadowColor = UIColor.black.cgColor
        bgLayer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        bgLayer.shadowRadius = 6.0
        bgLayer.shadowOpacity = 0.5
        
        bgLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        bgLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        bgLayer.colors = [
            UIColor.rgb(169.0, 166.0, 168.0).cgColor,
            UIColor.rgb(209.0, 207.0, 209.0).cgColor
        ]
        
        return bgLayer
    }()
    
    // MARK: - Cell LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        configAppearance()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let rect = CGRect(x: 10.0, y: 5.0, width: self.bounds.size.width - 20.0, height: self.bounds.size.height - 10.0)
        backgroundLayer.frame = rect
        backgroundLayer.shadowPath = UIBezierPath(roundedRect: rect, cornerRadius: 2.0).cgPath
    }
    
    // MARK: - Cell Appearance
    private func configAppearance() {
        self.selectionStyle = .none
        self.backgroundColor = UIColor.clear
        
        self.layer.masksToBounds = true
        self.layer.insertSublayer(backgroundLayer, at: 0)                
    }
    
    private func updateContentAppearance(_ isSelected: Bool) {
        
    }
}
