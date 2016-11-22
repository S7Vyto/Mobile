//
//  NetworkService.swift
//  SVNewsletter
//
//  Created by Sam on 21/11/2016.
//  Copyright © 2016 Semyon Vyatkin. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

typealias CompletionBlock = ([Any]?) -> Void
typealias ExceptionBlock = (NSError?) -> Void

class NetworkService {
    private let codeKey = "resultCode"
    private let codeValue = "OK"
    private let errorMsgKey = "plainMessage"
    private let resultKey = "payload"
            
    
    func request(url: String, completionBlock: @escaping CompletionBlock, exceptionBlock: @escaping ExceptionBlock) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        Alamofire.request(url)
            .validate()
            .response { [unowned self] (response) in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                guard let httpStatus = response.response?.statusCode, httpStatus == 200 else {
                    let host = response.request!.url!.host!
                    let errorMsg = response.error?.localizedDescription ?? "Server returns unsupported response"
                    
                    exceptionBlock(NSError(domain: host, code: 0, userInfo: ["errorMsg" : errorMsg]))
                    return
                }
                
                guard let data = response.data else {
                    exceptionBlock(nil)
                    return
                }
                
                let json = JSON(data: data)
                let isValidResult = json[self.codeKey].string == self.codeValue
                
                guard isValidResult else {
                    let host = response.request!.url!.host!
                    let errorMsg = json[self.errorMsgKey].stringValue
                    
                    exceptionBlock(NSError(domain: host, code: -1, userInfo: ["errorMsg" : errorMsg]))
                    return
                }
                
                completionBlock(json[self.resultKey].array)
        }
    }
}
