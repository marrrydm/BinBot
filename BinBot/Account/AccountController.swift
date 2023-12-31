import UIKit

final class AccountController: UIViewController {
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.text = "tabbar.account".localize()
        view.font = .systemFont(ofSize: 18, weight: .bold)
        view.textAlignment = .center
        return view
    }()

    private lazy var privacyView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.26, green: 0.276, blue: 0.33, alpha: 1)
        view.layer.cornerRadius = 10
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(policyAction)))
        return view
    }()

    private let privacyViewLabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.text = "account.policy".localize()
        view.font = .systemFont(ofSize: 13, weight: .regular)
        return view
    }()

    private let privacyImg = UIImageView(image: UIImage(named: "toRight"))

    private lazy var termsView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.26, green: 0.276, blue: 0.33, alpha: 1)
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(termsAction)))
        return view
    }()

    private let termsViewLabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.text = "account.terms".localize()
        view.font = .systemFont(ofSize: 13, weight: .regular)
        return view
    }()

    private let termsImg = UIImageView(image: UIImage(named: "toRight"))

    private lazy var logoutView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.26, green: 0.276, blue: 0.33, alpha: 1)
        view.isUserInteractionEnabled = true
        view.layer.cornerRadius = 10
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(logoutAction)))
        return view
    }()

    private let logoutViewLabel: UILabel = {
        let view = UILabel()
        view.text = "Log out".localize()
        view.textColor = .white
        view.font = .systemFont(ofSize: 13, weight: .regular)
        return view
    }()

    private let logoutImg = UIImageView(image: UIImage(named: "toRight"))

    private lazy var deleteView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.26, green: 0.276, blue: 0.33, alpha: 1)
        view.isUserInteractionEnabled = true
        view.layer.cornerRadius = 10
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(deleteAction)))
        return view
    }()

    private let deleteViewLabel: UILabel = {
        let view = UILabel()
        view.textColor = UIColor(red: 1, green: 0.277, blue: 0.277, alpha: 1)
        view.text = "account.delete".localize()
        view.font = .systemFont(ofSize: 13, weight: .regular)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.165, green: 0.169, blue: 0.188, alpha: 1)
        setupUI()
    }
}

private extension AccountController {
    private func setupUI() {
        view.addSubviews(titleLabel, privacyView, termsView, logoutView, deleteView)
        privacyView.addSubviews(privacyViewLabel, privacyImg)
        termsView.addSubviews(termsViewLabel, termsImg)
        logoutView.addSubviews(logoutViewLabel, logoutImg)
        deleteView.addSubviews(deleteViewLabel)

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        privacyView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }

        privacyViewLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
        }

        privacyImg.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
            make.height.width.equalTo(24)
        }

        termsView.snp.makeConstraints { make in
            make.top.equalTo(privacyView.snp.bottom).offset(1)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }

        termsViewLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
        }

        termsImg.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
            make.height.width.equalTo(24)
        }

        logoutView.snp.makeConstraints { make in
            make.top.equalTo(termsView.snp.bottom).offset(1)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }

        logoutViewLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
        }

        logoutImg.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
            make.height.width.equalTo(24)
        }

        deleteView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }

        deleteViewLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
        }
    }
}

private extension AccountController {
    @objc func policyAction() {
        if let url = URL(string: "https://www.freeprivacypolicy.com/live/f043dd2d-3b13-4a96-b1d9-5c0adbdbc0b8"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }

    @objc func termsAction() {
        if let url = URL(string: "https://www.freeprivacypolicy.com/live/12043b8e-f70e-4ef8-86cc-e12492390923"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }

    @objc func pop() {
        navigationController?.popViewController(animated: true)
    }

    @objc func logoutAction() {
        UserDefaults.standard.set(false, forKey: UserData.SettingsKeys.showedAuth.rawValue)
        deleteAccount()
    }

    @objc func deleteAction() {
        let alertError = UIAlertController(title: "DeleteData".localize(), message: nil, preferredStyle: .alert)
        alertError.addAction(UIAlertAction(title: "Yes".localize(), style: .default, handler: { _ in
            self.deleteAccount()
            UserDefaults.standard.set(false, forKey: UserData.SettingsKeys.showedAuth.rawValue)
            UserDefaults.standard.set(false, forKey: UserData.SettingsKeys.showedTrade.rawValue)
            UserDefaults.standard.set(false, forKey: UserData.SettingsKeys.isWorkQuiz.rawValue)
            UserDefaults.standard.set("", forKey: UserData.SettingsKeys.login.rawValue)
            UserDefaults.standard.set(1000, forKey: UserData.SettingsKeys.balance.rawValue)
        }))
        alertError.addAction(UIAlertAction(title: "No".localize(), style: .default, handler: nil))
        present(alertError, animated: true)
    }
}

private extension AccountController {
    func deleteAccount() {
        let vc = TabBarController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false)
    }
}
