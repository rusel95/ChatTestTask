//
//  Day.swift
//  Core
//
//  Created by Ruslan Popesku on 12/5/18.
//  Copyright © 2018 Yalantis. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

public class Day: Object {
    
     @objc public enum IntervalType: Int {
        case work, shortBreak, longBreak
    }
    
    @objc public dynamic var id: Int = -1
    @objc public dynamic var currentIntervalType: IntervalType = IntervalType.work
    @objc public dynamic var totalWorkTime: Int16 = 0
    @objc public dynamic var totalWorkIntervals: Int16 = 0
    @objc public dynamic var totalBreakTime: Int16 = 0
    @objc public dynamic var totalBreakIntervals: Int16 = 0
    @objc public dynamic var date: Date = Date()
    
    public override static func primaryKey() -> String? {
        return "id"
    }
    
}
