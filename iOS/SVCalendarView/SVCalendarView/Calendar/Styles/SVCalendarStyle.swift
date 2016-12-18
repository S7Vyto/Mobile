//
//  SVCalendarStyle.swift
//  SVCalendarView
//
//  Created by Semyon Vyatkin on 18/10/2016.
//  Copyright © 2016 Semyon Vyatkin. All rights reserved.
//

import Foundation
import UIKit

/**
 Calendar's style
 This class contains values on which depends look of calendar view
 */

public enum SVCalendarControlls {
    case container, calendar, switcher, navigation, header1, header2, time
}

struct SVCalendarStyle {
    struct Background {
        var normalColor: UIColor?
        var selectedColor: UIColor?
    }
    
    struct Button {
        var normalColor: UIColor?
        var selectedColor: UIColor?
        var radius: CGFloat = 0
    }
    
    struct Layer {
        var normalColor: UIColor?
        var selectedColor: UIColor?
        var radius: CGFloat = 0
    }
    
    struct Text {
        var font: UIFont?
        var normalColor: UIColor?
        var selectedColor: UIColor?
    }
    
    var background: Background
    var button: Button
    var layer: Layer
    var text: Text
    
    init(for control: SVCalendarControlls) {
        self.background = Background()
        self.button = Button()
        self.layer = Layer()
        self.text = Text()
        
        configStyleForController(control)
    }

    fileprivate mutating func configStyleForController(_ control: SVCalendarControlls) {
        switch control {
        case .container:
            background.normalColor = UIColor.clear
            break
            
        case .calendar:
            background.normalColor = UIColor.clear
            
            button.normalColor = UIColor.clear
            button.selectedColor = UIColor.red
            break
            
        case .navigation:
            break
            
        case .switcher:
            background.normalColor = UIColor.clear
            
            button.normalColor = UIColor.clear
            button.selectedColor = UIColor.rgb(117.0, 141.0, 177.0, 1)
            
            layer.radius = 4.0
            
            text.normalColor = UIColor.rgb(89.0, 109.0, 155.0, 1)
            text.selectedColor = UIColor.rgb(255.0, 255.0, 255.0, 1)
            text.font = UIFont.systemFont(ofSize: 13.0)
            
            break
            
        case .header1:
            background.normalColor = UIColor.clear
            break
            
        case .header2:
            background.normalColor = UIColor.clear
            break
            
        case .time:
            background.normalColor = UIColor.clear
            break
        }
    }
}
