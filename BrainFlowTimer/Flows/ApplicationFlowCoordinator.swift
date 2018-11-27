//
//  ApplicationFlowCoordinator.swift
//
//  Copyright © 2016 Yalantis. All rights reserved.
//

import UIKit
import Core
import Swinject

final class ApplicationFlowCoordinator: EventNode {
    
    private let window: UIWindow
    private let userSessionController: UserSessionController
    private let container: Container
    
    // MARK: init
    
    init(window: UIWindow, userSessionController: UserSessionController) {
        self.window = window
        self.userSessionController = userSessionController
        self.container = Container {
            ApplicationFlowAssembly(userSessionController).assemble(container: $0)
        }
        
        super.init()
    }
    
    func execute() {
        if let session = userSessionController.restorePreviousSession() {
            presentMainModule(with: session)
        } else {
            presentLoginModule()
        }
    }
    
    // MARK: Modules presentation
    
    fileprivate func presentLoginModule() {
        let flowCoordinator: AuthFlowCoordinator = container.autoresolve(argument: self)
        addHandler { [weak self] (event: AuthEvent) in
            self?.handle(event)
        }
        setWindowRootViewController(with: flowCoordinator.createFlow())
    }
    
    fileprivate func presentMainModule(with userSession: UserSession) {
        let flowCoordinator: MainFlowCoordinator = container.autoresolve(arguments: self, userSession)
        addHandler { [weak self] (event: MainFlowEvent) in
            self?.handle(event)
        }
        setWindowRootViewController(with: flowCoordinator.createFlow())
    }
    
    // MARK: Helpers
    
    private func setWindowRootViewController(with viewController: UIViewController) {
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
    
    private func handle(_ event: AuthEvent) {
        switch event {
        case .login(let userSession):
            presentMainModule(with: userSession)
        }
    }
    
    private func handle(_ event: MainFlowEvent) {
        switch event {
        case .logout:
            userSessionController.closeSession()
            
            presentLoginModule()
            
        }
    }
    
}
