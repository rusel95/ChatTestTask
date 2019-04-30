//
//  AuthFlowAssembly.swift
//  Buyper
//
//  Created by Ruslan Popesku on 4/30/19.
//  Copyright © 2019 Buyper. All rights reserved.
//

import Swinject
import SwinjectAutoregistration
import Core

final class AuthFlowAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container
            .register(AuthenticationViewController.self) { (resolver: Resolver, parent: EventNode) in
                let model = AuthenticationModel(
                    parent
//                    userSession: resolver.autoresolve(),
//                    userService: resolver.autoresolve()
                )
                let controller = StoryboardScene.Authentication.authenticationViewController.instantiate()
                controller.viewModel = AuthenticationViewModel(model: model)
                return controller
            }
            .inObjectScope(.transient)
        
    }
    
}
