//
//  SVCalendarConfiguration.swift
//  SVCalendarView
//
//  Created by Semyon Vyatkin on 18/10/2016.
//  Copyright © 2016 Semyon Vyatkin. All rights reserved.
//

import Foundation

struct SVCalendarType: OptionSet, Hashable {
    let rawValue: Int
    var hashValue: Int {
        return rawValue
    }
    
    static let all = SVCalendarType(rawValue: 0)
    static let day = SVCalendarType(rawValue: 1 << 0)
    static let week = SVCalendarType(rawValue: 1 << 1)
    static let month = SVCalendarType(rawValue: 1 << 2)
    static let quarter = SVCalendarType(rawValue: 1 << 3)
    static let year = SVCalendarType(rawValue: 1 << 4)
    
    static let defaultTypes = [SVCalendarType.day, SVCalendarType.month, SVCalendarType.year]
    static let testTypes = [SVCalendarType.day, SVCalendarType.week, SVCalendarType.month, SVCalendarType.quarter, SVCalendarType.year]
}

public class SVCalendarConfiguration {
    static let shared = SVCalendarConfiguration()
    
    var types = SVCalendarType.testTypes
    var minYear: Int = 2000
    var maxYear: Int = 2020
    
    var isHeaderSection1Visible = true
    var isHeaderSection2Visible = false
    var isTimeSectionVisible = true
}
