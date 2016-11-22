//
//  StringExtension.swift
//  SVNewsletter
//
//  Created by Sam on 22/11/2016.
//  Copyright © 2016 Semyon Vyatkin. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    func removeSpecialSymbols() -> String {
        guard let encodedData = self.data(using: .utf8) else {
            return self
        }
        
        let options = [
            NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
            NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue
        ] as [String : Any]
        
        do {
            let decodedString = try NSAttributedString(data: encodedData,
                                                       options: options,
                                                       documentAttributes: nil)
            return decodedString.string
        }
        catch {
            print(error.localizedDescription)
            return self
        }
    }
}
