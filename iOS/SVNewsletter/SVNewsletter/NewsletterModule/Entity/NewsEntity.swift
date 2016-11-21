//
//  NewsEntity.swift
//  SVNewsletter
//
//  Created by Sam on 20/11/2016.
//  Copyright © 2016 Semyon Vyatkin. All rights reserved.
//

import Foundation

protocol NewsEntityInterface: class {
    var id: Int { get }
    var name: String { get }
    var desc: String { get }
    var publicationDate: TimeInterval { get }
    
    init(id: Int, name: String, desc: String, publicationDate: TimeInterval)
}

class NewsEntity: NewsEntityInterface {
    var id: Int
    var name: String
    var desc: String
    var publicationDate: TimeInterval

    required init(id: Int, name: String, desc: String, publicationDate: TimeInterval) {
        self.id = id
        self.name = name
        self.desc = desc
        self.publicationDate = publicationDate
    }
}
