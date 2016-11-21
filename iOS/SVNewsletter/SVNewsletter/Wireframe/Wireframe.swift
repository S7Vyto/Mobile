//
//  Wireframe.swift
//  SVNewsletter
//
//  Created by Sam on 21/11/2016.
//  Copyright © 2016 Semyon Vyatkin. All rights reserved.
//

import Foundation
import UIKit

class Wireframe {
    
    func showRootViewController(_ viewController: UIViewController, in window: UIWindow?) {
        let navigationController = window?.rootViewController as! UINavigationController
        navigationController.viewControllers = [viewController]
    }
}
