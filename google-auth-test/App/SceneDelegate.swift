import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func changeRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard let window = self.window else {
            return
        }

        // Change the root view controller to your specific view controller
        window.rootViewController = vc
        UIView.transition(with: window,
                          duration: 0.5,
                          options: [.transitionCrossDissolve],
                          animations: nil,
                          completion: nil)
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }

        // Create a new window and set the scene's window
        let newWindow = UIWindow(windowScene: windowScene)
        window = newWindow

        // Set the root view controller
        let rootViewController = SignInVC()
        let navigationController = UINavigationController(rootViewController: rootViewController)
        newWindow.rootViewController = navigationController

        // Make the window visible
        newWindow.makeKeyAndVisible()
    }

    // Other scene delegate methods...
}
