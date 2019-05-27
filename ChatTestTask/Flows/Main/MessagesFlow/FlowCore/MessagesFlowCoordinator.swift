//
//  ChatFlowCoordinator.swift
//  ChatTestTask
//
//  Created by Ruslan Popesku on 5/25/19.
//  Copyright © 2019 Buyper. All rights reserved.
//

import Swinject
import SwinjectAutoregistration

enum MessagesNavigationEvent: Event {
    case presentChat(selectedMessage: UserChat)
}

final class MessagesFlowCoordinator: EventNode, FlowCoordinator {
    
    weak var containerViewController: UIViewController?
    
    private var rootViewController: MessagesViewController?
    
    private let container: Container
    
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
        case .presentChat(let selectedChat):
            let controller: ChatViewController = container.autoresolve(arguments: self, selectedChat)
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    func createFlow() -> UIViewController {
        let controller: MessagesViewController = container.autoresolve(argument: self)
        controller.title = L10n.messagesTabTitle
        rootViewController = controller
        
        return controller
    }
    
}
