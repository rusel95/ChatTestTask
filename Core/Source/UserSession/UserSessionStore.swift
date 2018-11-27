
final class UserSessionStore {
    
    private let effectiveStore: KeyValueStorage = UserDefaults.standard
    
    private let id: String
    
    init(id: String) {
        self.id = id
    }
 
    var user: User? {
        get {
            if
                let json = effectiveStore.object(forKey: key(for: "user")) as? [String: Any],
                let user = User(JSON: json)
            {
                return user
            }
            
            return nil
        }
        
        set {
            if let newValue = newValue {
                let json = newValue.toJSON()
                effectiveStore.set(json, forKey: key(for: "user"))
            } else {
                effectiveStore.set(nil, forKey: key(for: "user"))
            }
        }
    }
    
    var credentials: Credentials? {
        get {
            if
                let data = effectiveStore.object(forKey: key(for: "credentials")) as? Data,
                let credentials = NSKeyedUnarchiver.unarchiveObject(with: data) as? Credentials
            {
                return credentials
            }
            return nil
        }
        
        set {
            if let newValue = newValue {
                let data = NSKeyedArchiver.archivedData(withRootObject: newValue)
                effectiveStore.set(data, forKey: key(for: "credentials"))
            } else {
                effectiveStore.set(nil, forKey: key(for: "credentials"))
            }
        }
    }
    
    private func key(for value: String) -> String {
        return IDGen.make(for: value)
    }
}
