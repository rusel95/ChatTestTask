//
//  RealmService.swift
//  Core
//
//  Created by Ruslan Popesku on 11/30/18.
//  Copyright © 2018 Yalantis. All rights reserved.
//

import Foundation
import RealmSwift

public final class RealmService {
    
    public static let shared = RealmService()
    
    public var realm: Realm {
        let config = Realm.Configuration()
        
        do {
            let realm = try Realm(configuration: config)
            return realm
        } catch let error as NSError {
            fatalError("Error opening realm: \(error)")
        }
    }
    
    fileprivate init() {}

}
