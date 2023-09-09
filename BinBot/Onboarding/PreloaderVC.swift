import UIKit

class VCLoad: UIViewController {
    private var clock = Timer()
    private var img = UIImageView(image: UIImage(named: "logo"))

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.165, green: 0.169, blue: 0.188, alpha: 1)

        view.addSubview(img)
        img.translatesAutoresizingMaskIntoConstraints = false
        img.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        img.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        img.heightAnchor.constraint(equalToConstant: 133).isActive = true
        img.widthAnchor.constraint(equalToConstant: 133).isActive = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            let vc = UserDefaults.standard.bool(forKey: "showOnb") == true ? TabBarController() : Onboarding1()

            UserDefaults.standard.bool(forKey: "showOnb") == true ? UserDefaults.standard.set(false, forKey: UserData.SettingsKeys.isFirst.rawValue) : UserDefaults.standard.set(true, forKey: UserData.SettingsKeys.isFirst.rawValue)

            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        })
    }
}
