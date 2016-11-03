//
//  SVCalendarDate.swift
//  SVCalendarView
//
//  Created by Semyon Vyatkin on 19/10/2016.
//  Copyright © 2016 Semyon Vyatkin. All rights reserved.
//

import Foundation

/**
 Calendar date
 This class keep info for special date
 */

public class SVCalendarDate {
    var isCurrent: Bool = false
    var isEnabled: Bool = true
    var isWeekend: Bool = false
    var title: String
    var value: Date
    var type: SVCalendarType
    
    init(isEnabled: Bool, isCurrent: Bool, isWeekend: Bool, title: String, value: Date, type: SVCalendarType) {
        self.isEnabled = isEnabled
        self.isCurrent = isCurrent
        self.isWeekend = isWeekend
        self.title = title
        self.value = value
        self.type = type
    }
}
