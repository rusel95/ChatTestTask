//
//  LoginModel.swift
//
//  Copyright © 2016 Yalantis. All rights reserved.
//

import Foundation
import RxSwift
import Core

enum LoginEvent: Event {
    
    case login(userSession: UserSession)
    
}

final class LoginModel: EventNode {

    let requestState = PublishSubject<RequestState>()
    
    private let userSessionController: UserSessionController
    
    init(parent: EventNode, userSessionController: UserSessionController) {
        self.userSessionController = userSessionController
        
        super.init(parent: parent)
    }
    
    func login() {
        requestState.onNext(.started)
        userSessionController.openSession().continueWith { [weak self] task in
            if let result = task.result {
                self?.requestState.onNext(.finished)
                self?.raise(event: LoginEvent.login(userSession: result))
            } else if let error = task.error {
                self?.requestState.onNext(.failed(error))
            }
        }
    }
    
}
