//
//  watchDateTime.swift
//  WatchFace
//
//  Created by Tony Monckton on 26/08/2017.
//  Copyright © 2017 PsoinicDesign.co.uk. All rights reserved.
//

import Foundation
import UIKit

class watchDateTime {
    var year:Int
    var month:Int
    var day:Int
    var hour:Int
    var minute:Int
    var second:Int
    var dateTimeComponents: DateComponents? = nil
    
    init()
    {
        year    = 0
        month   = 0
        day     = 0
        hour    = 0
        minute  = 0
        second  = 0
    }
    
    var hourProgress: CGFloat {
        get {   return CGFloat(hour)/12.0   }
    }
    
    var minuteProgress: CGFloat {
        get {   return CGFloat(minute)/60.0   }
    }
    
    var secondProgress: CGFloat {
        get {   return CGFloat(second)/60.0   }
    }
    
    
    func update()
    {
        let userCalendar        = Calendar.current
        let currentDateTime     = Date()
        let requestedComponents: Set<Calendar.Component> = [.year,.month,.day,.hour,.minute,.second]
        
        dateTimeComponents  = userCalendar.dateComponents(requestedComponents, from: currentDateTime)
        
        year    = Int(dateTimeComponents!.year!)
        month   = Int(dateTimeComponents!.month!)
        day     = Int(dateTimeComponents!.day!)
        hour    = Int(dateTimeComponents!.hour!)
        minute  = Int(dateTimeComponents!.minute!)
        second  = Int(dateTimeComponents!.second!)
        
        if (hour>12)    { hour -= 12    }
        
//        print("time: hour:\(hour), minuet:\(minute), second:\(second)")
    }
}
