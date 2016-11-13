import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
       
        let windowFrame = UIScreen.main.bounds
        window = UIWindow(frame: windowFrame)

        let mainVC = ViewController(withMock: RHMockCellsModel())
        mainVC.title = "RHPreviewCell"

        let navigationController = UINavigationController(rootViewController: mainVC)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
}
