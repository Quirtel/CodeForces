import Foundation

protocol Contextual {
    var context: Context? { get set }
}

// 'ServiceLocator' pattern
class Context {
    let preferences: Preferences
    let networkService: NetworkService
    let realmService: RealmService
    
    let dayTime = TimeInterval(exactly: 60*60*24)!

    private init(preferences: Preferences,
                 networkService: NetworkService,
                 realmService: RealmService) {
        self.preferences = preferences
        self.networkService = networkService
        self.realmService = realmService
    }
    
    
    
    
}




extension Context {
    
    static func createFileContext() -> Context? {
        let prefs = Preferences()
        let context = Context(
            preferences: prefs,
            networkService: NetworkService(),
            realmService: RealmService()
        )
        
        //force-updating data using NetworkService
        
        
        
        return context
    }
}
