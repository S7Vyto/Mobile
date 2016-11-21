//
//  Connection.swift
//  SVNewsletter
//
//  Created by Sam on 20/11/2016.
//  Copyright © 2016 Semyon Vyatkin. All rights reserved.
//

import Foundation

struct Connection {
    static let apiVersion = "v1"
    static let baseURL = "https://api.tinkoff.ru"
    
    static var newsURL: String {
        return baseURL + "/" + apiVersion + "/" + "news"
    }
    
    static var newsContentURL: String {
        return baseURL + "/" + apiVersion + "/" + "news_content?id="
    }
}
