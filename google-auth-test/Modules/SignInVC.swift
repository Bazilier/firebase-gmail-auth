import UIKit
import GoogleSignIn
import Firebase
import SnapKit

class SignInVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            if error != nil || user == nil {
                // Not signed in
            } else {
                // Already signed in
                self.navigateToDashboard()
            }
        }

        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground

        // Create Sign In Button
        let googleSignInButton = GIDSignInButton()
        googleSignInButton.style = .wide
        googleSignInButton.addTarget(self, action: #selector(googleSignIn), for: .touchUpInside)

        view.addSubview(googleSignInButton)

        // Set constraints using SnapKit
        googleSignInButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(20)
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
    }
    
    //signInButtonTapped()
    //emailTextFieldChanged()
    @objc func googleSignIn() {
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { user, error in
            if let error = error {
                print("Ошибка аутентификации через Google: \(error.localizedDescription)")
                return
            }
            self.navigateToDashboard()
        }
    }


    private func navigateToDashboard() {
        // Set up tab bar controller with view controllers

        let manageViewController = SettingsVC()
        manageViewController.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "slider.horizontal.3"), tag: 2)

        let tabBarViewController = UITabBarController()
        tabBarViewController.viewControllers = [manageViewController]
        tabBarViewController.tabBar.barTintColor = .black
        tabBarViewController.tabBar.backgroundColor = .yellow

        // Get the SceneDelegate from the windowScene property
        if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
            // Call the changeRootViewController function in the SceneDelegate
            sceneDelegate.changeRootViewController(tabBarViewController)
        }
    }
}

