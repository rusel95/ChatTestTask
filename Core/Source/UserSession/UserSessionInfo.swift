
import Foundation

struct Credentials {
    let oauthToken: String
}

struct UserSessionInfo {
    
    let identifier: String
    let user: User
    let credentials: Credentials
    
    var accessToken: String { return credentials.oauthToken }
    
    init(user: User, credentials: Credentials) {
        self.user = user
        self.identifier = String(user.id)
        self.credentials = credentials
    }
    
}
