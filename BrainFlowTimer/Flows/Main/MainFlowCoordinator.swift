//
//  MainFlowCoordinator.swift
//
//  Copyright © 2016 Yalantis. All rights reserved.
//

import UIKit
import Core
import Swinject

enum MainFlowEvent: Event {
    
}

final class MainFlowCoordinator: EventNode, FlowCoordinator {
    
    weak var containerViewController: UIViewController?
    
    private let container: Container
    
    init(parent: EventNode, container: Container) {
        self.container = Container(parent: container) {
            MainFlowAssembly().assemble(container: $0)
        }
        
        super.init(parent: parent)
    }
    
    func createFlow() -> UIViewController {
        let controller: MainMenuViewController = container.autoresolve(argument: self)
        addHandlers()
        return controller
    }
    
    private func addHandlers() {
        addHandler { [weak self] (event: MainMenuEvent) in
            self?.handle(event)
        }
    }
    
    private func handle(_ event: MainMenuEvent) {
        switch event {
        default:
            break
        }
    }
    
}
