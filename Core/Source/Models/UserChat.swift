//
//  Day.swift
//  Core
//
//  Created by Ruslan Popesku on 12/5/18.
//  Copyright © 2018 Yalantis. All rights reserved.
//

import Foundation
import RealmSwift

public class UserChat: Object {
    
    @objc public dynamic var id: Int = -1
    @objc public dynamic var profileURL: URL? = nil
    @objc public dynamic var fullName: String = ""
    @objc public dynamic var receivedDate: Date? = nil
    @objc public dynamic var lastMessageText: String = ""
    @objc public dynamic var role: String = ""
    @objc public dynamic var currentLocationPlace: String = ""
    
    public override static func primaryKey() -> String? {
        return "id"
    }
    
    public static func construct(from json: [String: Any]) -> UserChat? {
        return update(from: json) ?? UserChat(json: json)
    }
    
    convenience init?(json: [String: Any]) {
        self.init()
        
        guard let id: Int = json["id"] as? Int else {
            return nil
        }
        
        self.id = id
        
        self.profileURL = json["profile_URL"] as? URL
        self.fullName = json["full_name"] as! String
        self.receivedDate = AppFormatter.Date.serverDate.date(from: json["received_date"] as? String ?? "")
        self.lastMessageText = json["lastMessageText"] as! String
        self.role = json["role"] as! String
        self.currentLocationPlace = json["current_location_name"] as! String
    }
    
    private static func update(from json: [String: Any]) -> UserChat? {
        guard let identifier: Int = json["id"] as? Int,
            let userChatFromRealm = RealmService.shared.realm.object(ofType: UserChat.self,
                                                                        forPrimaryKey: identifier) else {
                return nil
        }
        if let profileURLString: String = json["title"] as? String,
            let profileURL = URL(string: profileURLString) {
            userChatFromRealm.profileURL = profileURL
        }
        if let fullName: String = json["full_name"] as? String {
            userChatFromRealm.fullName = fullName
        }
        if let receiveDateString: String = json["receive_date"] as? String {
            userChatFromRealm.receivedDate = AppFormatter.Date.serverDate.date(from: receiveDateString)
        }
        if let lastMessageText: String = json["last_message_text"] as? String {
            userChatFromRealm.lastMessageText = lastMessageText
        }
        if let role: String = json["role"] as? String {
            userChatFromRealm.role = role
        }
        if let currentLocationPlace: String = json["current_location_place"] as? String {
            userChatFromRealm.currentLocationPlace = currentLocationPlace
        }
        
        return userChatFromRealm
    }
    
    static func == (lhs: UserChat, rhs: UserChat) -> Bool {
        return lhs.id == rhs.id
    }
}
