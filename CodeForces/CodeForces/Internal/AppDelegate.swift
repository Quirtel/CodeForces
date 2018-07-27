import UIKit
import Moya

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let contestsVC = StoryboardScene.Contests.contestsViewController.instantiate()
        contestsVC.title = L10n.ContestsVc.title
        let contestsNC = UINavigationController(rootViewController: contestsVC)
        
        let tasksVC = StoryboardScene.Tasks.tasksViewController.instantiate()
        tasksVC.title = L10n.TasksVc.title
        let tasksNC = UINavigationController(rootViewController: tasksVC)
        
        let tabBarController = UITabBarController()
        tabBarController.setViewControllers([contestsNC, tasksNC], animated: false)
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = tabBarController
        self.window = window
        window.makeKeyAndVisible()
        
        
        //testing code here
        
        let provider = MoyaProvider<ContestAPI>()
        provider.request(.list(gym: false)) { result in
            switch result {
            case .success(let moyaResponse):
                print("success: \(moyaResponse.description)")
                do {
                    let result = try moyaResponse.map(Response<[Contest]>.self)
                    switch result.status {
                    case .OK:
                        if let contests = result.result {
                            for c in contests {
                                print("NEW CONTEST: \(c)")
                            }
                        }
                    case .FAILED:
                        print("Server returned 'FAILED' with comment: \(result.comment ?? "<no-comment>")")
                    }
                    
                } catch {
                    print("Serialization error \(error)")
                }
            case .failure(let error):
                print("error: \(error)")
            }
        }
        
        
        
        
        return true
    }
}

