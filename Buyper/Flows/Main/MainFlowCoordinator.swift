//
//  MainFlowCoordinator.swift
//
//  Copyright © 2016 Yalantis. All rights reserved.
//

import UIKit
import Core
import Swinject

enum MainFlowEvent: Event {
     case openSettings
     case openStatistic
}

final class MainFlowCoordinator: EventNode, FlowCoordinator {
    
    weak var containerViewController: UIViewController?
    
    private let container: Container
    
    init(parent: EventNode, container: Container) {
        self.container = Container(parent: container) {
            MainFlowAssembly().assemble(container: $0)
        }
        super.init(parent: parent)
        
        addHandlers()
    }
    
    func createFlow() -> UIViewController {
        let controller: TimerViewController = container.autoresolve(argument: self)
        
        return controller
    }
    
    private func addHandlers() {
        addHandler { [weak self] (event: MainFlowEvent) in
            switch event {
            case .openSettings:
                self?.openSettings()
            case .openStatistic:
                self?.openStatistic()
            }
        }
    }
    
    private func openSettings() {
        let settingsController: SettingsViewController = container.autoresolve(argument: self)
        navigationController?.pushViewController(settingsController, animated: true)
    }
    
    private func openStatistic() {
        let statisticController: StatisticViewController = container.autoresolve(argument: self)
        navigationController?.pushViewController(statisticController, animated: true)
    }
    
}
