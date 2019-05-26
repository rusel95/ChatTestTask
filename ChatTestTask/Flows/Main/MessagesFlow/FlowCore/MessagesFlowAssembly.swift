//
//  ChatFlowAssembler.swift
//  ChatTestTask
//
//  Created by Ruslan Popesku on 5/25/19.
//  Copyright © 2019 Buyper. All rights reserved.
//

import Swinject
import SwinjectAutoregistration
import Core
import RxCocoa

final class MessagesFlowAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container
            .register(MessagesViewController.self) { (_, parent: EventNode) in
                let model = MessagesModel(parent: parent)
                let viewController = StoryboardScene.Messages.messagesViewController.instantiate()
                viewController.viewModel = MessagesViewModel(model: model)
                
                return viewController
            }
            .inObjectScope(.transient)
        
        container
            .register(ChatViewController.self) { (_, parent: EventNode, userChat: UserChat) in
                let model = ChatModel(parent: parent, userChat: userChat)
                let viewController = StoryboardScene.Messages.chatViewController.instantiate()
                viewController.viewModel = ChatViewModel(model: model)
                
                return viewController
            }
            .inObjectScope(.transient)
        
    }
}
