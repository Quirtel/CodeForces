import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, Contextual {
    
    let context = Context.createContext()
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let contestsVC = StoryboardScene.Contests.contestsViewController.instantiate()
        contestsVC.title = L10n.ContestsVc.title
        contestsVC.context = context
        let contestsNC = CustomNavigationController(rootViewController: contestsVC)
        if #available(iOS 11.0, *) {
            contestsNC.navigationBar.prefersLargeTitles = true
        }
        
        let tasksVC = StoryboardScene.Tasks.tasksViewController.instantiate()
        tasksVC.title = L10n.TasksVc.title
        tasksVC.context = context
        let tasksNC = CustomNavigationController(rootViewController: tasksVC)
        if #available(iOS 11.0, *) {
            tasksNC.navigationBar.prefersLargeTitles = true
        }
        
        let settingsVC = StoryboardScene.Settings.settingsViewController.instantiate()
        settingsVC.title = L10n.SettingsVc.title
        settingsVC.context = context
        let settingsNC = CustomNavigationController(rootViewController: settingsVC)
        if #available(iOS 11.0, *) {
            settingsNC.navigationBar.prefersLargeTitles = true
        }
        
        let tabBarController = CustomTabBarController()
        tabBarController.setViewControllers([contestsNC, tasksNC, settingsNC], animated: false)
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = tabBarController
        self.window = window
        window.makeKeyAndVisible()

        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        context?.contentService.updateDatabaseIfNeeded()
    }
}

