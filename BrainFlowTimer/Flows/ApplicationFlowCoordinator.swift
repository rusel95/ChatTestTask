//
//  ApplicationFlowCoordinator.swift
//
//  Copyright © 2016 Yalantis. All rights reserved.
//

import UIKit
import Core
import Swinject

enum ApplicationEvent: Event {
    
    case applicationDidEnterBackground
    case applicationWillEnterForeground
    
}

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
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        self.raise(event: ApplicationEvent.applicationDidEnterBackground)
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        self.raise(event: ApplicationEvent.applicationWillEnterForeground)
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
