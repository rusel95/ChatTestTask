import Swinject
import SwinjectAutoregistration
import Core

final class MainFlowAssembly: Assembly {

    func assemble(container: Container) {
        assembleUI(in: container)
    }
    
    private func assembleUI(in container: Container) {
        container.register(MainMenuViewController.self) { (_, parent: EventNode) in
            let controller = StoryboardScene.Main.instantiateMainMenuViewController()
            let model = MainMenuModel(parent: parent)
            controller.viewModel = MainMenuViewModel(model: model)
            return controller
        }
    }
}
