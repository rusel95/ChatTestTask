//
//  Duration.swift
//  Core
//
//  Created by Ruslan Popesku on 11/30/18.
//  Copyright © 2018 Yalantis. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

public class Durations: Object, Decodable {
    
    @objc public dynamic var id: Int = -1
    @objc public dynamic var work: Int16 = 0
    @objc public dynamic var shortBreak: Int16 = 0
    @objc public dynamic var longBreak: Int16 = 0
    @objc public dynamic var dailyGoal: Int16 = 0
    @objc public dynamic var sessionsUntilLongBreak: Int8 = 0
    
    public required init() {
        super.init()
        self.id = -1
        self.work = 1500
        self.shortBreak = 300
        self.longBreak = 900
        self.dailyGoal = 8
        self.sessionsUntilLongBreak = 2
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
    
    public override static func primaryKey() -> String? {
        return "id"
    }
    
}
