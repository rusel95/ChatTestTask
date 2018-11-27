//
//  UserSessionController.swift
//
//  Copyright © 2016 Yalantis. All rights reserved.
//

import BoltsSwift
import APIClient

public final class UserSessionController {
    
    public var canRestoreUserSession: Bool {
        guard let identifier = userSessionIdentifier, !identifier.isEmpty else { return false }
        
        return true
    }
    
    private let storage: KeyValueStorage
    private let authService = UserSessionAuthService()
    
    private static let userSessionIdentifierKey = "\(Bundle.main.bundleIdentifier!).userSession.identifier"
    
    public private(set) var userSession: UserSession? {
        didSet {
            oldValue?.close()
            userSession?.open()
            
            userSessionIdentifier = userSession?.id
        }
    }
    
    private var userSessionIdentifier: String? {
        get {
            return storage.object(forKey: UserSessionController.userSessionIdentifierKey) as? String
        }
        set {
            storage.set(newValue, forKey: UserSessionController.userSessionIdentifierKey)
            storage.saveChanges()
        }
    }
    
    // MARK: - Init
    
    /**
     - parameter storage: A storage that conforms to `KeyValueStorage` protocol
    */
    public init(storage: KeyValueStorage = UserDefaults.standard) {
        self.storage = storage
    }
    
    // MARK: Session managment

    @discardableResult
    public func openSession() -> Task<UserSession> {
        return authService.login().continueOnSuccessWith { data in
            let userSession = UserSession(initializationData: data)
            self.userSession = userSession
            return userSession
        }
    }
    
    public func closeSession() {
        assert(userSession != nil, "Can`t close nil session")
        
        userSession = nil
    }
    
    // MARK: - Session Restoration
    
    @discardableResult
    public func restorePreviousSession() -> UserSession? {
        assert(userSession == nil, "Can`t open 2 sessions")
        
        guard canRestoreUserSession else { return nil }
        guard let identifier = userSessionIdentifier,
            !identifier.isEmpty,
            let session = UserSession(restoringFromID: identifier) else {
            return nil
        }
        
        self.userSession = session
        return session
    }
    
}
