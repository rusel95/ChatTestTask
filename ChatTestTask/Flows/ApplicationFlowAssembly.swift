//
//  ApplicationFlowAssembler.swift
//  ChatTestTask
//
//  Created by Ruslan Popesku on 4/26/19.
//  Copyright © 2019 Ruslan Popesku. All rights reserved.
//

import Swinject
import SwinjectAutoregistration
import RxCocoa

final class ApplicationFlowAssembly: Assembly {
    
    func assemble(container: Container) {
//        container.register(AnalyticsService.self) { _ in
//            return AnalyticsService()
//            }
//            .inObjectScope(.container)
//        
//        container.register(SocketService.self) { _ in
//            return SocketService(userSession: container.autoresolve())
//            }
//            .inObjectScope(.container)
//        
//        container.register(
//            WebContainerCoordinator.self
//        ) { (_: Resolver, parent: EventNode, linkObject: LinkDTOObject) in
//            WebContainerCoordinator(
//                parent: parent,
//                linkObject: linkObject
//            )
//            }
//            .inObjectScope(.transient)
    }
    
}
