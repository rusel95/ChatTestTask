import Swinject
import SwinjectAutoregistration
import Core

final class MainFlowAssembly: Assembly {

    func assemble(container: Container) {
        assembleUI(in: container)
    }
    
    private func assembleUI(in container: Container) {
        container.register(TimerViewController.self) { (_, parent: EventNode) in
            let controller = StoryboardScene.Main.instantiateMainMenuViewController()
            let model = TimerModel(parent: parent)
            controller.viewModel = TimerViewModel(model: model)
            return controller
        }
    }
}
