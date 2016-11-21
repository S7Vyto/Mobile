//
//  AppDelegate.swift
//  SVNewsletter
//
//  Created by Sam on 19/11/2016.
//  Copyright © 2016 Semyon Vyatkin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var assemblyService: AssemblyService!


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        assemblyService = AssemblyService()
        assemblyService.presentInitialController(in: window)
        
        return true
    }
}

