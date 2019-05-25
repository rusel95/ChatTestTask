//
//  ChatFlowCoordinator.swift
//  ChatTestTask
//
//  Created by Ruslan Popesku on 5/25/19.
//  Copyright © 2019 Buyper. All rights reserved.
//

import Swinject
import SwinjectAutoregistration
import Core

enum MessagesNavigationEvent: Event {
    case presentChat(selectedMessage: Message)
}

final class MessagesFlowCoordinator: EventNode, FlowCoordinator {
    
    weak var containerViewController: UIViewController?
    private let container: Container
    
    private var rootViewController: MessagesViewController?
    
    init(parent: EventNode, container: Container) {
        self.container = Container(parent: container)
        
        super.init(parent: parent)
        
        MessagesFlowAssembly().assemble(container: self.container)
        addHandlers()
    }
    
    func addHandlers() {
        addHandler { [weak self] (event: MessagesNavigationEvent) in
            self?.handle(event)
        }
    }
    
    private func handle(_ event: MessagesNavigationEvent) {
        switch event {
        case .presentChat:
        //TODO: made presenting here
            break
        }
    }
    
    func createFlow() -> UIViewController {
        let controller: MessagesViewController = container.autoresolve(argument: self)
        controller.title = L10n.mapTabTitle
        rootViewController = controller
        
        return controller
    }
    
}
