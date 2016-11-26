//
//  NewsletterDetailsViewController.swift
//  SVNewsletter
//
//  Created by Sam on 23/11/2016.
//  Copyright © 2016 Semyon Vyatkin. All rights reserved.
//

import UIKit

protocol NewsletterDetailsInterface: class {
    func showNewsletterDetails(_ content: String?)
}

class NewsletterDetailsViewController: UIViewController, NewsletterDetailsInterface {
    @IBOutlet weak var textView: UITextView!
    
    private lazy var backgroundLayer: CAGradientLayer = {
        let bgLayer = CAGradientLayer()
        bgLayer.frame = self.view.bounds
        bgLayer.shouldRasterize = true
        bgLayer.rasterizationScale = UIScreen.main.scale
        bgLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        bgLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        bgLayer.colors = [
            UIColor.rgb(52.0, 73.0, 93.0).cgColor,
            UIColor.rgb(40.0, 55.0, 71.0).cgColor
        ]
        bgLayer.locations = [
            0.0,
            1.0
        ]
        
        return bgLayer
    }()
    
    var presenter: NewsletterDetailsPresenter?
    
    // MARK: - Controller LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configAppearance()
        presenter?.updateNewsletterDetails()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Controller Appearance
    private func configAppearance() {
        self.automaticallyAdjustsScrollViewInsets = false
        self.edgesForExtendedLayout = []                
        
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = UIColor.rgb(248.0, 248.0, 28.0)
        self.navigationController?.navigationBar.barTintColor = UIColor.rgb(51.0, 43.0, 77.0)
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName: UIColor.rgb(248.0, 248.0, 28.0),
            NSFontAttributeName: UIFont.systemFont(ofSize: 16)
        ]
        
        self.view.backgroundColor = UIColor.clear
        self.view.layer.masksToBounds = true
        self.view.layer.insertSublayer(backgroundLayer, at: 0)
    }
    
    // MARK: - NewsletterDetailsInterface    
    func showNewsletterDetails(_ content: String?) {
        textView.text = content
        textView.scrollRangeToVisible(NSRange(location:0, length:0))
    }
}
