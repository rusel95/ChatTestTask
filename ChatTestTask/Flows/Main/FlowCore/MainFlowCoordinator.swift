//
//  MainFlowCoordinator.swift
//
//  Copyright © 2016 Yalantis. All rights reserved.
//

import UIKit
import Swinject

enum MainFlowEvent: Event {
    
    case switchToList
    case switchToMap
    case switchToMessages
    case switchToOrders
    case switchToProfile
    
}

enum Tab: Int {
    
    case list
    case map
    case messages
    case orders
    case profile
    
}

final class MainFlowCoordinator: EventNode, FlowCoordinator {
    
    weak var containerViewController: UIViewController?
    
    private var tabBarController: MainContainerController!
    
    private let container: Container
    
    private lazy var exploreController: UIViewController = {
        let flowCoordinator: ExploreFlowCoordinator = container.autoresolve(argument: self)
        let exploreViewController = flowCoordinator.createFlow()
        let containerViewController = UINavigationController(rootViewController: exploreViewController)
        
        containerViewController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        containerViewController.navigationBar.shadowImage = UIImage()
        containerViewController.navigationBar.isTranslucent = true
        containerViewController.view.backgroundColor = .clear
        
        flowCoordinator.containerViewController = containerViewController
        
        let item = UITabBarItem(
            title: L10n.exploreTabTitle,
            image: Asset.tabIconExploreUnselected.image.withRenderingMode(.alwaysOriginal),
            selectedImage: Asset.tabIconExploreSelected.image.withRenderingMode(.alwaysOriginal)
        )
        item.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: ColorName.tabBarFontUnselectedColor],
            for: .normal
        )
        item.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: ColorName.tabBarFontSelectedColor],
            for: .selected
        )
        exploreViewController.tabBarItem = item
        
        return containerViewController
    }()
    
    private lazy var mapController: UIViewController = {
        let flowCoordinator: MapFlowCoordinator = container.autoresolve(argument: self)
        
        let viewController = flowCoordinator.createFlow()
        let containerViewController = UINavigationController(rootViewController: viewController)
        
        viewController.navigationController?.isNavigationBarHidden = true
        containerViewController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        containerViewController.navigationBar.shadowImage = UIImage()
        containerViewController.navigationBar.isTranslucent = true
        containerViewController.view.backgroundColor = .clear
        
        flowCoordinator.containerViewController = containerViewController
        
        let item = UITabBarItem(
            title: L10n.mapTabTitle,
            image: Asset.tabIconMapUnselected.image.withRenderingMode(.alwaysOriginal),
            selectedImage: Asset.tabIconMapSelected.image.withRenderingMode(.alwaysOriginal)
        )
        item.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: ColorName.tabBarFontUnselectedColor],
            for: .normal
        )
        item.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: ColorName.tabBarFontSelectedColor],
            for: .selected
        )
        viewController.tabBarItem = item
        
        return containerViewController
    }()
    
    private lazy var messagesController: UIViewController = {
        let flowCoordinator: MessagesFlowCoordinator = container.autoresolve(argument: self)
        
        let viewController = flowCoordinator.createFlow()
        let containerViewController = UINavigationController(rootViewController: viewController)
        
//        viewController.navigationController?.isNavigationBarHidden = true
//        containerViewController.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        containerViewController.navigationBar.shadowImage = UIImage()
//        containerViewController.navigationBar.isTranslucent = true
//        containerViewController.view.backgroundColor = .clear
        
        flowCoordinator.containerViewController = containerViewController
        
        let item = UITabBarItem(
            title: L10n.messagesTabTitle,
            image: Asset.tabIconMapUnselected.image.withRenderingMode(.alwaysOriginal),
            selectedImage: Asset.tabIconMapSelected.image.withRenderingMode(.alwaysOriginal)
        )
        item.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: ColorName.tabBarFontUnselectedColor],
            for: .normal
        )
        item.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: ColorName.tabBarFontSelectedColor],
            for: .selected
        )
        viewController.tabBarItem = item
        
        return containerViewController
    }()
    
    private lazy var ordersController: UIViewController = {
        let flowCoordinator: OrdersFlowCoordinator = container.autoresolve(argument: self)
        
        let viewController = flowCoordinator.createFlow()
        let containerViewController = UINavigationController(rootViewController: viewController)
        
        viewController.navigationController?.isNavigationBarHidden = true
        containerViewController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        containerViewController.navigationBar.shadowImage = UIImage()
        containerViewController.navigationBar.isTranslucent = true
        containerViewController.view.backgroundColor = .clear
        
        flowCoordinator.containerViewController = containerViewController
        
        let item = UITabBarItem(
            title: L10n.ordersTabTitle,
            image: Asset.tabIconMapUnselected.image.withRenderingMode(.alwaysOriginal),
            selectedImage: Asset.tabIconMapSelected.image.withRenderingMode(.alwaysOriginal)
        )
        item.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: ColorName.tabBarFontUnselectedColor],
            for: .normal
        )
        item.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: ColorName.tabBarFontSelectedColor],
            for: .selected
        )
        viewController.tabBarItem = item
        
        return containerViewController
    }()
    
    private lazy var profileController: UIViewController = {
        let flowCoordinator: ProfileFlowCoordinator = container.autoresolve(argument: self)
        let viewController = flowCoordinator.createFlow()
        let containerViewController = UINavigationController(rootViewController: viewController)
        flowCoordinator.containerViewController = containerViewController
        
        let item = UITabBarItem(
            title: L10n.profileTabTitle,
            image: Asset.tabIconProfileUnselected.image.withRenderingMode(.alwaysOriginal),
            selectedImage: Asset.tabIconProfileSelected.image.withRenderingMode(.alwaysOriginal)
        )
        item.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: ColorName.tabBarFontSelectedColor],
            for: .normal
        )
        item.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: ColorName.tabBarFontUnselectedColor],
            for: .selected
        )
        viewController.tabBarItem = item
        return containerViewController
    }()
    
    init(parent: EventNode, container: Container) {
        self.container = Container(parent: container) {
            MainFlowAssembly().assemble(container: $0)
        }
        super.init(parent: parent)
        
        addHandlers()
    }
    
    func createFlow() -> UIViewController {
        let tabBarController: MainContainerController = container.autoresolve(argument: self)
        self.tabBarController = tabBarController
        assembleActualTabs()
        containerViewController = self.tabBarController
        self.tabBarController.selectedIndex = Tab.messages.rawValue
        return tabBarController
    }
    
    // MARK: - Private Methods
    
    private func assembleActualTabs() {
        tabBarController.viewControllers = [
            exploreController,
            mapController,
            messagesController,
            ordersController,
            profileController
        ]
    }
    
    private func addHandlers() {
        addHandler { [weak self] (event: MainFlowEvent) in
            switch event {
            case .switchToList:
                self?.tabBarController.selectedIndex = Tab.list.rawValue
            case .switchToMap:
                self?.tabBarController.selectedIndex = Tab.map.rawValue
            case .switchToMessages:
                self?.tabBarController.selectedIndex = Tab.messages.rawValue
            case .switchToOrders:
                self?.tabBarController.selectedIndex = Tab.orders.rawValue
            case .switchToProfile:
                self?.tabBarController.selectedIndex = Tab.profile.rawValue
            }
        }
    }
    
}
