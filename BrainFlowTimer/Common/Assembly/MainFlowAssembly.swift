
import Swinject
import SwinjectAutoregistration
import APIClient
import Core

final class MainFlowAssembly: Assembly {
    
    private let userSession: UserSession
    
    init(_ userSession: UserSession) {
        self.userSession = userSession
    }
    
    func assemble(container: Container) {
        assembleUI(in: container)
    }
    
    private func assembleUI(in container: Container) {
        container.register(MainMenuViewController.self) { (resolver, parent: EventNode) in
            let controller = StoryboardScene.Main.instantiateMainMenuViewController()
            let model = MainMenuModel(parent: parent, user: resolver.autoresolve())
            controller.viewModel = MainMenuViewModel(model: model)
            return controller
        }
    }
}
