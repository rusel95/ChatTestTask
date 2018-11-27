import APIClient
import BoltsSwift

final class UserSessionAuthService {

    private var networkClient: NetworkClient

    // MARK: - Init
    
    init() {
        let networkClient = UserSessionAuthService.makeDefaultDependencies()
        self.networkClient = networkClient
    }
    
    // MARK: -
    
    func login() -> Task<UserSessionInfo> {
        let source = TaskCompletionSource<UserSessionInfo>()
        return source.task
    }
    
    private func resetDependencies() {
        let networkClient = UserSessionAuthService.makeDefaultDependencies()
        self.networkClient = networkClient
    }
    
    // MARK: - Dependencies
    
    private static func makeDefaultDependencies() -> NetworkClient {
        let networkClient = APIClient(
            requestExecutor: AlamofireRequestExecutor(baseURL: Constants.API.baseURL),
            plugins: []
        )
        return networkClient
    }
    
}
