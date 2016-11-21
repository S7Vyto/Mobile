//
//  AssemblyService.swift
//  SVNewsletter
//
//  Created by Sam on 21/11/2016.
//  Copyright © 2016 Semyon Vyatkin. All rights reserved.
//

import Foundation
import UIKit

class AssemblyService {
    var newletterWireframe: NewsletterWireframe!
    
    init() {
        let wireframe = Wireframe()
        newletterWireframe = NewsletterWireframe()
        newletterWireframe.rootWireframe = wireframe        
    }
    
    func presentInitialController(in window: UIWindow?) {
        newletterWireframe.presentNewsletterListView(window)
    }
}
