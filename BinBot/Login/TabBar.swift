import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        let date = Date()
        if UserData.dateStartQuiz == nil {
            UserDefaults.standard.set(date, forKey: UserData.SettingsKeys.dateStartQuiz.rawValue)
        }

        UserDefaults.standard.set(true, forKey: UserData.SettingsKeys.isWorkQuiz.rawValue)

        self.delegate = self
        self.tabBar.backgroundColor = UIColor(red: 0.141, green: 0.149, blue: 0.184, alpha: 1)
        self.tabBar.tintColor = UIColor(red: 0.141, green: 0.149, blue: 0.184, alpha: 1)
        self.tabBar.barTintColor = UIColor(red: 0.141, green: 0.149, blue: 0.184, alpha: 1)
        self.tabBar.layer.borderWidth = 0.5
        self.tabBar.layer.borderColor = UIColor(red: 0.182, green: 0.197, blue: 0.254, alpha: 1).cgColor

        let appearance = UITabBarItem.appearance()
        let attributes = [
            NSAttributedString.Key.font:
                UIFont.systemFont(ofSize: 10, weight: .semibold),
            NSAttributedString.Key.foregroundColor: UIColor(red: 0.584, green: 0.612, blue: 0.663, alpha: 1)
        ]

        appearance.setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)

        let attributesSelected = [
            NSAttributedString.Key.font:
                UIFont.systemFont(ofSize: 10, weight: .semibold),
            NSAttributedString.Key.foregroundColor: UIColor(red: 1, green: 0.855, blue: 0.267, alpha: 1)
        ]

        appearance.setTitleTextAttributes(attributesSelected as [NSAttributedString.Key : Any], for: .selected)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let navBar = UINavigationController(rootViewController: PlatformController())
        navBar.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navBar.navigationBar.shadowImage = UIImage()
        navBar.navigationBar.isTranslucent = true
        let tradeControllerItem = UITabBarItem(title: "tabbar.platform".localize(), image: UIImage(named: "platform")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "platform_selected")?.withRenderingMode(.alwaysOriginal))
        navBar.tabBarItem = tradeControllerItem

        let botController = UINavigationController(rootViewController: BotController())
        botController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        botController.navigationBar.shadowImage = UIImage()
        botController.navigationBar.isTranslucent = true
        let robotControllerItem = UITabBarItem(title: "tabbar.robot".localize(), image: UIImage(named: "robot")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "robot_selected")?.withRenderingMode(.alwaysOriginal))
        botController.tabBarItem = robotControllerItem

        let supportController = UINavigationController(rootViewController: SupportController())
        supportController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        supportController.navigationBar.shadowImage = UIImage()
        supportController.navigationBar.isTranslucent = true
        let supportControllerItem = UITabBarItem(title: "tabbar.support".localize(), image: UIImage(named: "support")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "support_selected")?.withRenderingMode(.alwaysOriginal))

        supportController.tabBarItem = supportControllerItem

        let accountController = AccountController()
        let accountControllerItem = UITabBarItem(title: "tabbar.account".localize(), image: UIImage(named: "account")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "account_selected")?.withRenderingMode(.alwaysOriginal))

        accountController.tabBarItem = accountControllerItem

        self.viewControllers = [navBar, botController, supportController, accountController]
    }
}
