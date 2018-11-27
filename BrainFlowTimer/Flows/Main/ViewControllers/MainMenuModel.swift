//
//  MainMenuModel.swift
//
//  Copyright © 2016 Yalantis. All rights reserved.
//

import Foundation
import Core

enum MainMenuEvent: Event {
    
    case logout
    
}

final class MainMenuModel: EventNode {
    
    let user: User
    
    init(parent: EventNode, user: User) {
        self.user = user
        
        super.init(parent: parent)
    }
    
    func logOut() {
        raise(event: MainMenuEvent.logout)
    }
    
}
