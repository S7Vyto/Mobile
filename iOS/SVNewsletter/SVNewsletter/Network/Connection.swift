//
//  Connection.swift
//  SVNewsletter
//
//  Created by Sam on 20/11/2016.
//  Copyright © 2016 Semyon Vyatkin. All rights reserved.
//

import Foundation

struct URLSettings {
    static let api = "v1"
    static let base = "https://api.tinkoff.ru"
}

enum URLPaths {
    case news
    case content(id: String)
    
    func url() -> String {
        switch self {
        case .news:
            return "\(URLSettings.base)/\(URLSettings.api)/news"
        case let .content(id):
            return "\(URLSettings.base)/\(URLSettings.api)/news_content?id=\(id)"
        }
    }
}
