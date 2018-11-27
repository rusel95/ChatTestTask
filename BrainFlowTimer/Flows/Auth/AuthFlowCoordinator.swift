//
//  AuthFlowCoordinator.swift
//
//  Copyright © 2016 Yalantis. All rights reserved.
//

import UIKit
import Core
import Swinject

enum AuthEvent: Event {
    
    case login(userSession: UserSession)
    
}

final class AuthFlowCoordinator: EventNode, FlowCoordinator {
    
    weak var containerViewController: UIViewController?
    
    private let resolver: Resolver
    
    init(parent: EventNode, resolver: Resolver) {
        self.resolver = resolver
        super.init(parent: parent)
    }
    
    func createFlow() -> UIViewController {
        let controller: LoginViewController = resolver.autoresolve(argument: self)
        addHandlers()
        return controller
    }
    
    func addHandlers() {
        addHandler { [weak self] (event: LoginEvent) in
            self?.handle(event)
        }
    }
    
    func handle(_ event: LoginEvent) {
        switch event {
        case .login(let userSession):
            raise(event: AuthEvent.login(userSession: userSession))
        }
    }
    
}
