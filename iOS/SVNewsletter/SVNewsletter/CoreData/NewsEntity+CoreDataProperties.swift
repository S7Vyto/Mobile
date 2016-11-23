//
//  NewsEntity+CoreDataProperties.swift
//  SVNewsletter
//
//  Created by Sam on 24/11/2016.
//  Copyright © 2016 Semyon Vyatkin. All rights reserved.
//

import Foundation
import CoreData

extension NewsEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NewsEntity> {
        return NSFetchRequest<NewsEntity>(entityName: "NewsEntity");
    }

    @NSManaged public var creationDate: Double
    @NSManaged public var id: String?
    @NSManaged public var modificationDate: Double
    @NSManaged public var name: String?
    @NSManaged public var publicationDate: Double
    @NSManaged public var text: String?
    @NSManaged public var content: String?
}
