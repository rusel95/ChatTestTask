//
//  AuthFlowAssembly.swift
//  ChatTestTask
//
//  Created by Ruslan Popesku on 4/30/19.
//  Copyright © 2019 Ruslan Popesku. All rights reserved.
//

import Swinject
import SwinjectAutoregistration

final class AuthFlowAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container
            .register(AuthenticationViewController.self) { (_: Resolver, parent: EventNode) in
                let model = AuthenticationModel(
                    parent
                )
                let controller = StoryboardScene.Authentication.authenticationViewController.instantiate()
                controller.viewModel = AuthenticationViewModel(model: model)
                return controller
            }
            .inObjectScope(.transient)
        
    }
    
}
