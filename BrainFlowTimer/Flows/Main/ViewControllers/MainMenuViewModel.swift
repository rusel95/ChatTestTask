//
//  MainMenuViewModel.swift
//
//  Copyright © 2016 Yalantis. All rights reserved.
//

import Foundation
import RxSwift

final class MainMenuViewModel {
    
    private let model: MainMenuModel
    
    let username: Variable<String>
    let avatar: Variable<URL?>
    
    var logOut: () -> Void {
        return model.logOut
    }
    
    init(model: MainMenuModel) {
        self.model = model
        self.username = Variable(model.user.nickname)
        self.avatar = Variable(model.user.avatarURL)
    }
    
}
