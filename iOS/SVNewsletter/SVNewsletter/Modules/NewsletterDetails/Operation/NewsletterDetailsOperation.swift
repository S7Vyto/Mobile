//
//  NewsletterDetailsOperation.swift
//  SVNewsletter
//
//  Created by Sam on 23/11/2016.
//  Copyright © 2016 Semyon Vyatkin. All rights reserved.
//

import Foundation
import UIKit

class NewsletterDetailsOperation: AsyncOperation {
    
    override func main() {
        guard !isCancelled else {
            state = .isFinished
            return
        }
        
        state = .isExecuting
        (UIApplication.shared.delegate as? AppDelegate)?
            .dataService
            .updateData(data.first!) { [unowned self] newsletters in
                self.finishBlock(newsletters)
                self.state = .isFinished
        }
    }
}
