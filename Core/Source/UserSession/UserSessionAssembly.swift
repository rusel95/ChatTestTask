
import Swinject
import SwinjectAutoregistration
import APIClient

final class UserSessionAssembly: Assembly {
    
    let userSession: UserSession
    
    // MARK: - Init
    
    init(_ userSession: UserSession) {
        self.userSession = userSession
    }
    
    func assemble(container: Container) {
        container.register(UserSession.self) { [unowned userSession] _ in return userSession }
        container.register(User.self, factory: { [unowned userSession] _ in return userSession.user })
        container.register(UserSessionStore.self) { resolver in
            let userSession: UserSession = resolver.autoresolve()
            return userSession.store
        }
        
        container.register(NetworkClient.self) { (resolver) in
            let networkClient = APIClient(
                requestExecutor: AlamofireRequestExecutor(baseURL: Constants.API.baseURL),
                plugins: []
            )
            return networkClient
        }.inObjectScope(.container)
    }
}
