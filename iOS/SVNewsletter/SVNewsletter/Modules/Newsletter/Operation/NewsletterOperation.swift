//
//  NewsletterOperation.swift
//  SVNewsletter
//
//  Created by Sam on 22/11/2016.
//  Copyright © 2016 Semyon Vyatkin. All rights reserved.
//

import UIKit

class NewsletterOperation: AsyncOperation {
    
    override func main() {
        guard !isCancelled else {
            state = .isFinished
            return
        }
        
        state = .isExecuting
        (UIApplication.shared.delegate as? AppDelegate)?
            .dataService
            .saveData(data) { [unowned self] in
                let dataService = (UIApplication.shared.delegate as? AppDelegate)?.dataService
                let newsletters = dataService?.fetchData(nil, sorts: [NSSortDescriptor(key: "publicationDate", ascending: false)])
                
                self.finishBlock(newsletters ?? [])
                self.state = .isFinished
        }
    }
}
