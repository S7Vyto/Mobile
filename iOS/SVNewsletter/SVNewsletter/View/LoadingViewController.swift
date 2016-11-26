//
//  LoadingViewController.swift
//  SVNewsletter
//
//  Created by Sam on 26/11/2016.
//  Copyright © 2016 Semyon Vyatkin. All rights reserved.
//

import UIKit

class FreeFormPresentationController: UIPresentationController {
    override var frameOfPresentedViewInContainerView: CGRect {
        return CGRect(x: 0.0, y: 0.0, width: 150.0, height: 150.0)
    }
}

class LoadingViewController: UIViewController, UIViewControllerTransitioningDelegate {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    static var identifier: String {
        return NSStringFromClass(LoadingViewController.self).replacingOccurrences(of: "SVNewsletter.", with: "")
    }
    
    static var indicator: LoadingViewController {
        let loadindIndicator = LoadingViewController(nibName: LoadingViewController.identifier, bundle: Bundle.main)
        
        loadindIndicator.modalTransitionStyle = .crossDissolve
        loadindIndicator.modalPresentationStyle = .overCurrentContext
        
        return loadindIndicator
    }
    
    // MARK: - Controller LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configAppearance()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Controller Appearance
    private func configAppearance() {        
        self.preferredContentSize = CGSize(width: 150.0, height: 150.0)
        
        self.view.backgroundColor = UIColor.clear
        self.view.isOpaque = false
    }
    
    // MARK: - Indicator Methods
    func showFrom(_ controller: UIViewController) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: { [weak controller, unowned self] in
            controller?.present(self, animated: true, completion: nil)
            controller?.transitioningDelegate = self
        })
    }
    
    func dismiss() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        })
    }
    
    // MARK: - UIViewControllerTransitioningDelegate
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return FreeFormPresentationController(presentedViewController: presented, presenting: presentingViewController)
    }
}
