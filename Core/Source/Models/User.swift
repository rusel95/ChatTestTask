//
//  User.swift
//
//  Copyright © 2016 Yalantis. All rights reserved.
//

import Foundation
import ObjectMapper

public final class User: Mappable {
    
    public var id = -1
    public var nickname = ""
    public var name = ""
    public var bio = ""
    public var location = ""
    public var company = ""
    
    public var avatarURL: URL? { return URL(string: avatarURLString) }
    public var blogURL: URL? { return URL(string: blogURLString) }
    
    private var avatarURLString = ""
    private var blogURLString = ""
    
    public init () {}
    public required init?(map: Map) {}
    
    public func mapping(map: Map) {
        id <- map["id"]
        nickname <- map["login"]
        name <- map["name"]
        bio <- map["bio"]
        location <- map["location"]
        company <- map["company"]
        avatarURLString <- map["avatar_url"]
        blogURLString <- map["blog"]
    }
}
