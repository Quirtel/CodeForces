import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let contestsSB = UIStoryboard(name: "Contests", bundle: nil)
        let contestsVC = contestsSB.instantiateViewController(withIdentifier: "ContestsViewController")
        contestsVC.title = "Contests"
        let contestsNC = UINavigationController(rootViewController: contestsVC)
        
        let tasksSB = UIStoryboard(name: "Tasks", bundle: nil)
        let tasksVC = tasksSB.instantiateViewController(withIdentifier: "TasksViewController")
        tasksVC.title = "Tasks"
        let tasksNC = UINavigationController(rootViewController: tasksVC)
        
        let tabBarController = UITabBarController()
        tabBarController.setViewControllers([contestsNC, tasksNC], animated: false)
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = tabBarController
        self.window = window
        window.makeKeyAndVisible()
        
        return true
    }
}

