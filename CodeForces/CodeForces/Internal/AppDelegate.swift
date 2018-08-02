import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let contestsVC = StoryboardScene.Contests.contestsViewController.instantiate()
        contestsVC.title = L10n.ContestsVc.title
        let contestsNC = UINavigationController(rootViewController: contestsVC)
        
        let tasksVC = StoryboardScene.Tasks.tasksViewController.instantiate()
        tasksVC.title = L10n.TasksVc.title
        tasksVC.context = NetworkService()
        let tasksNC = UINavigationController(rootViewController: tasksVC)
        if #available(iOS 11.0, *) {
            tasksNC.navigationBar.prefersLargeTitles = true
        }
        
        let tabBarController = UITabBarController()
        tabBarController.setViewControllers([contestsNC, tasksNC], animated: false)
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = tabBarController
        self.window = window
        window.makeKeyAndVisible()

        return true
    }
}

