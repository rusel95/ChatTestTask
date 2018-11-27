import Foundation
import Swinject

public final class UserSession {
    
    /**
     User session can be in the following states:
     
     - initial: after init(), does nothing
     - Opened: session has been opened successfuly, all services are running
     - Invalid: sessions credential has been invalidated and can not be renewd automatically (see `StoredCredentialProvider`).
     After session become invalid services stoped, but none of the data removed.
     - Closed: all services stoped, linked data such as intermediate sync state, credentials has been removed.
     */
    public enum State {
        case initial, opened, invalid, closed
    }
    
    public let id: String
    public let rootURL: URL
    public let container = Container()
    public private(set) var state: State = .initial {
        didSet {
            NotificationCenter.default.post(name: .UserSessionStateDidChange, object: self)
        }
    }
    
    public var user: User { return store.user! }
    
    let store: UserSessionStore
    
    private var initializationData: UserSessionInfo?
    
    // MARK: - Init
    
    init?(restoringFromID id: String) {
        self.id = id
        self.rootURL = URL(userSessionID: id)
        self.store = UserSessionStore(id: id)
        
        if store.credentials == nil {
            return nil
        }
    }
    
    init(initializationData: UserSessionInfo) {
        self.id = initializationData.identifier
        self.rootURL = URL(userSessionID: id)
        self.initializationData = initializationData
        self.store = UserSessionStore(id: id)
    }
    
    // MARK: - State Change
    
    func open() {
        assert(state == .initial, "Session can be opened once")
        
        UserSessionAssembly(self).assemble(container: container)
        
        if let data = initializationData {
            //swiftlint:disable force_try
            try! UserSessionBoostrapper(userSession: self).bootstrap(using: data)
            //swiftlint:enable force_try
        }
        
        if store.credentials != nil {
            state = .opened
//            startServices()
        } else {
            close(updateState: false)
            state = .invalid
        }
    }
    
    func close() {
        assert(state == .opened, "Only opened or invalid session can be closed")
        close(updateState: true)
    }
    
    private func close(updateState: Bool) {
        // stopServices()
        container.removeAll()
        
        state = .closed
    }
}

//extension UserSession: AccessTokenUpdaterDelegate {
//    
//    func accessTokenUpdaterRequiresAccessToken(_ updater: AccessTokenUpdater) -> AccessToken? {
//        return credentialStorage.userSessionToken
//    }
//    
//    func accessTokenUpdater(_ updater: AccessTokenUpdater, didUpdateAccessToken accessToken: AccessToken) {
//        credentialStorage.userSessionToken = accessToken
//    }
//    
//    func accessTokenUpdater(_ updater: AccessTokenUpdater, didInvalidateAccessToken accessToken: AccessToken) {
//        // SENTRY
//        Client.shared?.send(event: Event(level: .error, accessTokenInvalid: accessToken))
//        
//        credentialStorage.userSessionToken = nil
//        state = .invalid
//    }
//}

extension Notification.Name {
    
    static let UserSessionStateDidChange = Notification.Name(rawValue: "UserSession.UserSessionStateDidChange")
}

