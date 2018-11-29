import Swinject
import SwinjectAutoregistration
import Core

final class MainFlowAssembly: Assembly {

    func assemble(container: Container) {
        
        container.register(TimerViewController.self) { (_, parent: EventNode) in
            let controller = StoryboardScene.Timer.timerViewController.instantiate()
            let model = TimerModel(parent: parent)
            controller.viewModel = TimerViewModel(model: model)
            return controller
        }
        
        container.register(SettingsViewController.self) { (_, parent: EventNode) in
            let controller = StoryboardScene.Settings.settingsViewController.instantiate()
            let model = SettingsModel(parent: parent)
            controller.viewModel = SettingsViewModel(model: model)
            return controller
        }
        
    }
    
}
