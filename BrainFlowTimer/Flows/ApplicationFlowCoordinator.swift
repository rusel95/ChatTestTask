//
//  ApplicationFlowCoordinator.swift
//
//  Copyright © 2016 Yalantis. All rights reserved.
//

import UIKit
import Core
import Swinject

final class ApplicationFlowCoordinator: EventNode {
    
    public let container = Container()
    
    private let window: UIWindow
    private weak var application: UIApplication?

    // MARK: init
    
    init(window: UIWindow) {
        self.window = window
        
        super.init()
    }
    
    func execute() {
        presentMainModule()
    }
    
    // MARK: Modules presentation
    
    fileprivate func presentMainModule() {
        let flowCoordinator = MainFlowCoordinator(parent: self, container: container)
        let containerViewController = flowCoordinator.createFlow()
        flowCoordinator.containerViewController = containerViewController
        setWindowRootViewController(with: containerViewController)
    }
    
    // MARK: Helpers
    
    private func setWindowRootViewController(with viewController: UIViewController) {
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
    
    private func handle(_ event: MainFlowEvent) {
        switch event {
            
        }
    }
    
}
