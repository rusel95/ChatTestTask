//
//  AppDelegate.swift
//
//  Copyright © 2016 Yalantis. All rights reserved.
//

import UIKit
import Core
import Swinject

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let container = Container()
    let userSessionController = UserSessionController()
    
    var window: UIWindow?
    private var applicationFlowCoordinator: ApplicationFlowCoordinator!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]? = nil) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        applicationFlowCoordinator = ApplicationFlowCoordinator(
            window: window!,
            userSessionController: userSessionController
        )
        applicationFlowCoordinator.execute()
        
        return true
    }
    
}
