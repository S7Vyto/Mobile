//
//  Wireframe.swift
//  SVNewsletter
//
//  Created by Sam on 21/11/2016.
//  Copyright © 2016 Semyon Vyatkin. All rights reserved.
//

import Foundation
import UIKit

protocol WireframeProtocol: class {
    func showRootViewController(_ viewController: UIViewController, in window: UIWindow?)
    func viewControllerWith(name: String) -> UIViewController
}

class Wireframe: WireframeProtocol {
    
    func showRootViewController(_ viewController: UIViewController, in window: UIWindow?) {
        let navigationController = window?.rootViewController as! UINavigationController
        navigationController.viewControllers = [viewController]
    }
    
    // MARK: - Wireframe Methods
    func viewControllerWith(name: String) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let controller = storyboard.instantiateViewController(withIdentifier: name)
        
        return controller
    }
}
