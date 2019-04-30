//
//  OrdersFlowCoordinator.swift
//  Buyper
//
//  Created by Ruslan Popesku on 4/30/19.
//  Copyright © 2019 Buyper. All rights reserved.
//

import Swinject
import SwinjectAutoregistration
import Core

enum OrdersNavigationEvent: Event {
    
}

final class OrdersFlowCoordinator: EventNode, FlowCoordinator {
    
    weak var containerViewController: UIViewController?
    private let container: Container
    
    private var rootViewController: OrdersViewController?
    
    init(parent: EventNode, container: Container) {
        self.container = Container(parent: container)
        
        super.init(parent: parent)
        
        OrdersFlowAssembly().assemble(container: self.container)
        addHandlers()
    }
    
    func addHandlers() {
        addHandler { [weak self] (event: OrdersNavigationEvent) in
            self?.handle(event)
        }
    }
    
    private func handle(_ event: OrdersNavigationEvent) {
        switch event {
            
        }
    }
    
    func createFlow() -> UIViewController {
        let controller: OrdersViewController = container.autoresolve(argument: self)
        controller.title = L10n.ordersTabTitle
        rootViewController = controller
        
        return controller
    }
    
}
