
import Swinject
import SwinjectAutoregistration
import Core

final class ApplicationFlowAssembly: Assembly {
    
    let userSessionController: UserSessionController
    
    init(_ userSessionController: UserSessionController) {
        self.userSessionController = userSessionController
    }
    
    func assemble(container: Container) {
        container.register(
            UserSessionController.self,
            factory: { [unowned userSessionController] _ in return userSessionController }
        )
        
        assembleAuth(in: container)
        assembeMain(in: container)
    }
    
    private func assembleAuth(in container: Container) {
        container.autoregister(LoginModel.self, argument: EventNode.self, initializer: LoginModel.init)
        container.register(LoginViewController.self) { (resolver, parent: EventNode) in
            let controller = StoryboardScene.Auth.instantiateLogin()
            controller.viewModel = LoginViewModel(model: resolver.autoresolve(argument: parent))
            return controller
        }
        
        container.autoregister(argument: EventNode.self, initializer: AuthFlowCoordinator.init(parent:resolver:))
    }
    
    private func assembeMain(in container: Container) {
        container.register(MainFlowCoordinator.self) { (resolver, parent: EventNode, userSession: UserSession) in
            return MainFlowCoordinator(parent: parent, userSession: userSession)
        }
    }
}
