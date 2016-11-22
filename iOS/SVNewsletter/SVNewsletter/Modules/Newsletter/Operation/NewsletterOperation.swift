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
        
        var newsletters = [NewsEntity]()
        for json in data {
            let newsletter = NewsEntity(id: json["id"].intValue,
                                        name: json["name"].stringValue,
                                        desc: json["text"].stringValue.removeSpecialSymbols(),
                                        publicationDate: json["publicationDate"]["milliseconds"].doubleValue)
            
            newsletters.append(newsletter)
        }
        
        newsletters.sort { $0.publicationDate > $1.publicationDate }
        
        DispatchQueue.main.async { [weak self] in
            self?.finishBlock(newsletters)
        }
        
        state = .isFinished
    }
}
