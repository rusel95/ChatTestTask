
import Foundation
import Swinject

struct UserSessionBoostrapper {
    
    private let userSession: UserSession
    
    init(userSession: UserSession) {
        self.userSession = userSession
    }
    
    func bootstrap(using initData: UserSessionInfo) throws {
        assert(userSession.state == .initial)
        
        // Currently unused. In future releases where data model requires migration
        // this will allow us to inambiguously identify whethere we're running an update or have a fresh new install.
        // For update previous version will be equal to 1000, for fresh install to 0
//        CoreVersionRegistry(key: userSession.id).updateVersion(to: CoreVersion1000)
        
        //swiftlint:disable force_try
        try! FileManager.default.createDirectory(
            at: userSession.rootURL,
            withIntermediateDirectories: true,
            attributes: nil
        )
        //swiftlint:enable force_try

        userSession.store.user = initData.user
        userSession.store.credentials = initData.credentials
/*
        userSession.credentialStorage.userSessionToken = initData.accessToken
        userSession.credentialStorage.realmKey = Data(randomBytesOfLength: 64)!
        
        let realm: Realm = userSession.container.autoresolve()
        try realm.write {
            let user = User(id: initData.id)
            
            user.email = initData.email
            user.phone = initData.phone
            
            if let profile = initData.profile {
                user.profile = profile
            }
            
            realm.add(user)
            
            userSession.userStore.user = user
        }
 */
    }
    
    func teardown() {
        assert(userSession.state == .initial)

//        CoreVersionRegistry(key: userSession.id).reset()
        
//        userSession.credentialStorage.userSessionToken = nil
//        userSession.credentialStorage.realmKey = nil
        
        userSession.store.user = nil
        userSession.store.credentials = nil
        
        try? FileManager.default.removeItem(at: userSession.rootURL)
    }
}
