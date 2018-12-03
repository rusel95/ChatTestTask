//
//  Duration.swift
//  Core
//
//  Created by Ruslan Popesku on 11/30/18.
//  Copyright © 2018 Yalantis. All rights reserved.
//

import Foundation
import RealmSwift

//in seconds
public class Durations: Object {
    
    @objc public dynamic var workSession: Int16 = 1500
    @objc public dynamic var shortBreak: Int16 = 300
    @objc public dynamic var longBreak: Int16 = 900
    @objc public dynamic var dailyGoal: Int16 = 8
    @objc public dynamic var sessionUntilLongBreak: Int8 = 2
    
}
