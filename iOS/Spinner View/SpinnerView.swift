//
//  SpinnerView.swift
//
//  Created by Semyon Vyatkin on 10/06/16.
//  Copyright © 2016 Semyon Vyatkin. All rights reserved.
//

import Foundation

class SpinnerView {
    private lazy var indicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false;
        indicator.activityIndicatorViewStyle = .WhiteLarge
        indicator.hidesWhenStopped = true
        
        return indicator
    }()
    
    private lazy var indicatorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clearColor()
        label.textAlignment = .Center
        label.textColor = UIColor.whiteColor()
        label.font = UIFont(name: "HelveticaNeue-Light", size: 22.0)
        label.lineBreakMode = .ByWordWrapping
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var blurredView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.clearColor();
        view.hidden = true
        view.alpha = 0.0
        view.tag = 191919
        
        return view
    }()
    
    private static let instance = SpinnerView()
    private var indicatorText: String?
    
    static func sharedInstance() -> SpinnerView {
        return instance
    }
    
    private func blurredBackgroundView() -> UIImage {
        let bounds = UIScreen.mainScreen().bounds
        let scale = UIScreen.mainScreen().scale
        let topView = UIApplication.sharedApplication().keyWindow!.rootViewController!.view
        
        UIGraphicsBeginImageContextWithOptions(bounds.size, true, scale)
        topView.drawViewHierarchyInRect(bounds, afterScreenUpdates: true)
        
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        let blurredScreenshot = UIImageEffects.imageByApplyingBlurToImage(screenshot, withRadius: 6.0, tintColor: UIColor.blackColor().colorWithAlphaComponent(0.25), saturationDeltaFactor: 1.0, maskImage: nil)
        UIGraphicsEndImageContext()
        
        return blurredScreenshot
    }
    
    private func blurredLayer() -> CALayer {
        let blurredLayer = CALayer()
        let blurredImage = blurredBackgroundView().CGImage
        
        blurredLayer.contents = blurredImage
        blurredLayer.frame = UIScreen.mainScreen().bounds
        blurredLayer.masksToBounds = true
        
        return blurredLayer
    }
    
    private func clearSubViews() {
        for constraint in blurredView.constraints {
            blurredView.removeConstraint(constraint)
        }
        
        for constraint in indicatorView.constraints {
            indicatorView.removeConstraint(constraint)
        }
        
        for constraint in indicatorLabel.constraints {
            indicatorLabel.removeConstraint(constraint)
        }
    }
    
    private func setupAppearance() {
        clearSubViews()
        
        let topLayer = blurredLayer();
        blurredView.layer.addSublayer(topLayer)
        blurredView.addSubview(indicatorView)
        
        let centerXConst = NSLayoutConstraint(item: indicatorView, attribute: .CenterX, relatedBy: .Equal, toItem: blurredView, attribute: .CenterX, multiplier: 1.0, constant: 0.0)
        let centerYConst = NSLayoutConstraint(item: indicatorView, attribute: .CenterY, relatedBy: .Equal, toItem: blurredView, attribute: .CenterY, multiplier: 1.0, constant: 0.0)
        
        blurredView.addConstraints([centerXConst, centerYConst])
        blurredView.userInteractionEnabled = false
    
        let topView = UIApplication.sharedApplication().keyWindow!.rootViewController!.view
        topView.addSubview(blurredView)
        
        let topConst = NSLayoutConstraint(item: blurredView, attribute: .Top, relatedBy: .Equal, toItem: topView, attribute: .Top, multiplier: 1.0, constant: 0.0)
        let bottomConst = NSLayoutConstraint(item: blurredView, attribute: .Bottom, relatedBy: .Equal, toItem: topView, attribute: .Bottom, multiplier: 1.0, constant: 0.0)
        let leftConst = NSLayoutConstraint(item: blurredView, attribute: .Leading, relatedBy: .Equal, toItem: topView, attribute: .Leading, multiplier: 1.0, constant: 0.0)
        let rightConst = NSLayoutConstraint(item: blurredView, attribute: .Trailing, relatedBy: .Equal, toItem: topView, attribute: .Trailing, multiplier: 1.0, constant: 0.0)
        
        topView.addConstraints([topConst, bottomConst, leftConst, rightConst])
        topView.bringSubviewToFront(blurredView)
        topView.userInteractionEnabled = false                
    }
    
    private func setupAppearanceWithText(text: String) {
        clearSubViews()
        
        let topLayer = blurredLayer();
        blurredView.layer.addSublayer(topLayer)
        blurredView.addSubview(indicatorView)
        blurredView.addSubview(indicatorLabel)
        
        indicatorLabel.text = text
        
        let centerLabelXConst = NSLayoutConstraint(item: indicatorLabel, attribute: .CenterX, relatedBy: .Equal, toItem: blurredView, attribute: .CenterX, multiplier: 1.0, constant: 0.0)
        let centerLabelYConst = NSLayoutConstraint(item: indicatorLabel, attribute: .CenterY, relatedBy: .Equal, toItem: blurredView, attribute: .CenterY, multiplier: 1.0, constant: 0.0)
        let leftLabelConst = NSLayoutConstraint(item: indicatorLabel, attribute: .Leading, relatedBy: .Equal, toItem: blurredView, attribute: .Leading, multiplier: 1.0, constant: 15.0)
        let rightLabelConst = NSLayoutConstraint(item: indicatorLabel, attribute: .Trailing, relatedBy: .Equal, toItem: blurredView, attribute: .Trailing, multiplier: 1.0, constant: 15.0)
        
        let centerIndicatorXConst = NSLayoutConstraint(item: indicatorView, attribute: .CenterX, relatedBy: .Equal, toItem: blurredView, attribute: .CenterX, multiplier: 1.0, constant: 0.0)
        let topIndicatorConst = NSLayoutConstraint(item: indicatorLabel, attribute: .Top, relatedBy: .Equal, toItem: indicatorView, attribute: .Bottom, multiplier: 1.0, constant: 15.0)
        let widthIndicatorConst = NSLayoutConstraint(item: indicatorView, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .Width, multiplier: 1.0, constant: 35.0)
        let heightIndicatorConst = NSLayoutConstraint(item: indicatorView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .Height, multiplier: 1.0, constant: 35.0)
        
        blurredView.addConstraints([centerLabelXConst, centerLabelYConst, leftLabelConst, rightLabelConst, centerIndicatorXConst, topIndicatorConst, widthIndicatorConst, heightIndicatorConst])
        blurredView.userInteractionEnabled = false
        
        let topView = UIApplication.sharedApplication().keyWindow!.rootViewController!.view
        topView.addSubview(blurredView)
        
        let topConst = NSLayoutConstraint(item: blurredView, attribute: .Top, relatedBy: .Equal, toItem: topView, attribute: .Top, multiplier: 1.0, constant: 0.0)
        let bottomConst = NSLayoutConstraint(item: blurredView, attribute: .Bottom, relatedBy: .Equal, toItem: topView, attribute: .Bottom, multiplier: 1.0, constant: 0.0)
        let leftConst = NSLayoutConstraint(item: blurredView, attribute: .Leading, relatedBy: .Equal, toItem: topView, attribute: .Leading, multiplier: 1.0, constant: 0.0)
        let rightConst = NSLayoutConstraint(item: blurredView, attribute: .Trailing, relatedBy: .Equal, toItem: topView, attribute: .Trailing, multiplier: 1.0, constant: 0.0)
        
        topView.addConstraints([topConst, bottomConst, leftConst, rightConst])
        topView.bringSubviewToFront(blurredView)
        topView.userInteractionEnabled = false
    }
    
    func isSpinnerViewVisible() -> Bool {
        return blurredView.hidden == false && blurredView.alpha == 1.0
    }
    
    func showSpinnerIndicator() {
        setupAppearance()
        
        blurredView.hidden = false
        blurredView.alpha = 0.0
        
        indicatorView.startAnimating()
        UIView.animateWithDuration(0.35,
                                   delay: 0.0,
                                   options: .CurveEaseIn,
                                   animations: {
                                    self.blurredView.alpha = 1.0
            }) { (finished) in
                
        }
    }
    
    func showSpinnerIndicatorWithText(text: String) {
        setupAppearanceWithText(text)
        
        blurredView.hidden = false
        blurredView.alpha = 0.0
        
        indicatorView.startAnimating()
        UIView.animateWithDuration(0.35,
                                   delay: 0.0,
                                   options: .CurveEaseIn,
                                   animations: {
                                    self.blurredView.alpha = 1.0
        }) { (finished) in
            
        }
    }
    
    func hideSpinnerIndicator() {
        UIApplication.sharedApplication().keyWindow!.rootViewController!.view.userInteractionEnabled = true
        UIView.animateWithDuration(0.35,
                                   delay: 0.0,
                                   options: .CurveEaseIn,
                                   animations: {
                                    self.blurredView.alpha = 0.0
        }) { (finished) in
            if finished {
                self.blurredView.hidden = true
                self.indicatorView.stopAnimating()
                self.blurredView.removeFromSuperview()
            }
        }
    }
}