import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
       
        let windowFrame = UIScreen.mainScreen().bounds
        window = UIWindow(frame: windowFrame)

        let mainVC = ViewController(withMock: RHMockCellsModel())
        mainVC.title = "RHPreviewCell"
        let navigationController = UINavigationController(rootViewController: mainVC)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
}