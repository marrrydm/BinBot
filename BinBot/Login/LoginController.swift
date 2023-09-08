import UIKit
import SnapKit

class LoginVC: UIViewController {
    private let labelTitle: UILabel = {
        let view = UILabel()
        view.textColor = UIColor(red: 0.165, green: 0.169, blue: 0.188, alpha: 1)
        view.text = "title.login".localize()
        view.font = .systemFont(ofSize: 18, weight: .bold)
        view.numberOfLines = 0
        view.textAlignment = .center
        view.lineBreakMode = .byWordWrapping

        return view
    }()

    private lazy var btn1: UIButton = {
        let view = UIButton()
        view.backgroundColor = UIColor(red: 1, green: 0.855, blue: 0.267, alpha: 1)
        view.layer.cornerRadius = 6
        view.setTitleColor(UIColor(red: 0.165, green: 0.169, blue: 0.188, alpha: 1), for: .normal)
        view.setTitle("Sign in".localize(), for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        view.addTarget(self, action: #selector(tapButtonNext), for: .touchUpInside)

        return view
    }()

    private let emailTextField: TextField = {
        let view = TextField()
        view.backgroundColor = UIColor(red: 0.961, green: 0.969, blue: 0.965, alpha: 1)
        view.layer.cornerRadius = 10
        view.textColor = UIColor(red: 0.584, green: 0.612, blue: 0.663, alpha: 1)
        view.placeholder = "email".localize()
        view.font = .systemFont(ofSize: 15, weight: .regular)
        view.textAlignment = .left
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 0.855, green: 0.863, blue: 0.859, alpha: 1).cgColor

        return view
    }()

    private let passwordTextField: TextField = {
        let view = TextField()
        view.backgroundColor = UIColor(red: 0.961, green: 0.969, blue: 0.965, alpha: 1)
        view.layer.cornerRadius = 10
        view.textColor = UIColor(red: 0.584, green: 0.612, blue: 0.663, alpha: 1)
        view.placeholder = "password".localize()
        view.font = .systemFont(ofSize: 15, weight: .regular)
        view.textAlignment = .left
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 0.855, green: 0.863, blue: 0.859, alpha: 1).cgColor

        return view
    }()

    private lazy var btnMark: UIButton = {
        let view = UIButton()
        view.setBackgroundImage(UIImage(named: "noMark"), for: .normal)
        view.addTarget(self, action: #selector(btnMarkTap), for: .touchUpInside)
        view.isHidden = true

        return view
    }()

    private let lblConfirm: UILabel = {
        let view = UILabel()
        view.text = "confirm1".localize()
        view.textColor = UIColor(red: 0.584, green: 0.612, blue: 0.663, alpha: 1)
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        view.font = .systemFont(ofSize: 12, weight: .regular)
        view.textAlignment = .left
        view.isHidden = true

        return view
    }()

    private lazy var lblTerms: UnderlinedLabel = {
        let view = UnderlinedLabel()
        view.text = "confirm2".localize()
        view.textColor = UIColor(red: 0.584, green: 0.612, blue: 0.663, alpha: 1)
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        view.font = .systemFont(ofSize: 12, weight: .regular)
        view.textAlignment = .left
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapTerms)))
        view.isHidden = true

        return view
    }()

    private lazy var lblPolicy: UnderlinedLabel = {
        let view = UnderlinedLabel()
        view.text = "confirm3".localize()
        view.textColor = UIColor(red: 0.584, green: 0.612, blue: 0.663, alpha: 1)
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        view.font = .systemFont(ofSize: 12, weight: .regular)
        view.textAlignment = .left
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapPrivacy)))
        view.isHidden = true

        return view
    }()

    private lazy var lblAdult: UILabel = {
        let view = UILabel()
        view.text = "confirm4".localize()
        view.textColor = UIColor(red: 0.584, green: 0.612, blue: 0.663, alpha: 1)
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        view.font = .systemFont(ofSize: 12, weight: .regular)
        view.textAlignment = .left
        view.isHidden = true

        return view
    }()

    private lazy var lblTempFirst: UILabel = {
        let view = UILabel()
        view.text = "and".localize()
        view.textColor = UIColor(red: 0.584, green: 0.612, blue: 0.663, alpha: 1)
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        view.font = .systemFont(ofSize: 12, weight: .regular)
        view.textAlignment = .left
        view.isHidden = true

        return view
    }()

    private lazy var lblTempSecond: UILabel = {
        let view = UILabel()
        view.text = "and".localize()
        view.textColor = UIColor(red: 0.584, green: 0.612, blue: 0.663, alpha: 1)
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        view.font = .systemFont(ofSize: 12, weight: .regular)
        view.textAlignment = .left
        view.isHidden = true

        return view
    }()

    private lazy var lblForgot: UnderlinedLabel = {
        let view = UnderlinedLabel()
        view.text = "Forgot password?".localize()
        view.textColor = UIColor(red: 0.584, green: 0.612, blue: 0.663, alpha: 1)
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        view.font = .systemFont(ofSize: 12, weight: .regular)
        view.textAlignment = .left
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapForgot)))

        return view
    }()

    private lazy var lblNoAccount: UILabel = {
        let view = UILabel()
        view.text = "noAcc".localize()
        view.textColor = UIColor(red: 0.584, green: 0.612, blue: 0.663, alpha: 1)
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        view.font = .systemFont(ofSize: 12, weight: .regular)
        view.textAlignment = .left

        return view
    }()

    private lazy var btnSwitch: UIButton = {
        let view = UIButton()
        view.backgroundColor = UIColor(red: 0.804, green: 0.804, blue: 0.812, alpha: 1)
        view.layer.cornerRadius = 9
        view.setTitleColor(UIColor(red: 0.165, green: 0.169, blue: 0.188, alpha: 1), for: .normal)
        view.setTitle("createAcc".localize(), for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        view.addTarget(self, action: #selector(switchAction), for: .touchUpInside)

        return view
    }()

    private var indexSwitch = false

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        configureView()
        doneBtn()
    }

    private func configureView() {
        view.addSubview(labelTitle)
        view.addSubviews(emailTextField, passwordTextField)
        view.addSubviews(btnMark, lblConfirm, lblTerms, lblPolicy, lblAdult, lblTempFirst, lblTempSecond, lblForgot, btn1, lblNoAccount, btnSwitch)

        labelTitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(80)
            make.centerX.equalToSuperview()
        }

        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(labelTitle.snp.bottom).offset(23.5)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }

        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }

        btnMark.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(22)
            make.leading.equalToSuperview().offset(24)
            make.height.width.equalTo(20)
        }

        lblConfirm.snp.makeConstraints { make in
            make.bottom.equalTo(btnMark.snp.centerY).offset(-1)
            make.leading.equalTo(btnMark.snp.trailing).offset(8)
        }

        lblTerms.snp.makeConstraints { make in
            make.bottom.equalTo(btnMark.snp.centerY).offset(-1)
            make.leading.equalTo(lblConfirm.snp.trailing).offset(3)
        }

        lblTempFirst.snp.makeConstraints { make in
            make.bottom.equalTo(btnMark.snp.centerY).offset(-1)
            make.leading.equalTo(lblTerms.snp.trailing).offset(3)
        }

        lblPolicy.snp.makeConstraints { make in
            make.top.equalTo(btnMark.snp.centerY).offset(1)
            make.leading.equalTo(btnMark.snp.trailing).offset(8)
        }

        lblTempSecond.snp.makeConstraints { make in
            make.top.equalTo(btnMark.snp.centerY).offset(1)
            make.leading.equalTo(lblPolicy.snp.trailing).offset(3)
        }

        lblAdult.snp.makeConstraints { make in
            make.top.equalTo(btnMark.snp.centerY).offset(1)
            make.leading.equalTo(lblTempSecond.snp.trailing).offset(3)
        }

        lblForgot.snp.makeConstraints { make in
            make.centerY.equalTo(btnMark.snp.centerY)
            make.leading.equalToSuperview().offset(18)
        }

        btn1.snp.makeConstraints { make in
            make.top.equalTo(lblAdult.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(40)
            make.height.equalTo(50)
        }

        btnSwitch.snp.makeConstraints { make in
            make.top.equalTo(btn1.snp.bottom).offset(25)
            make.leading.equalTo(view.snp.centerX)
            make.height.equalTo(37)
            make.width.equalTo(100)
        }

        lblNoAccount.snp.makeConstraints { make in
            make.centerY.equalTo(btnSwitch.snp.centerY)
            make.trailing.equalTo(btnSwitch.snp.leading).offset(-10)
        }

    }
}

extension LoginVC {
    @objc private func tapForgot() {
        // forgot password
    }

    @objc private func tapTerms() {
        if let url = URL(string: "https://www.freeprivacypolicy.com/live/12043b8e-f70e-4ef8-86cc-e12492390923"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }

    @objc private func tapPrivacy() {
        if let url = URL(string: "https://www.freeprivacypolicy.com/live/f043dd2d-3b13-4a96-b1d9-5c0adbdbc0b8"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

extension LoginVC {
    private func doneBtn() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))

        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()

        emailTextField.inputAccessoryView = doneToolbar
        passwordTextField.inputAccessoryView = doneToolbar
    }

    @objc private func btnMarkTap(sender: UITapGestureRecognizer) {
        btnMark.isSelected ? btnMark.setBackgroundImage(UIImage(named: "noMark"), for: .normal) : btnMark.setBackgroundImage(UIImage(named: "mark"), for: .normal)
        btnMark.isSelected = !btnMark.isSelected
        let isValid = isValidEmail(emailTextField.text ?? "")
        if !emailTextField.text!.isEmpty && !passwordTextField.text!.isEmpty && isValid && btnMark.currentBackgroundImage == UIImage(named: "mark") {
            btn1.alpha = 1
        } else {
            btn1.alpha = 0.5
        }
    }

    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

    @objc private func tapButtonNext(sender: UITapGestureRecognizer) {
        let isValid = isValidEmail(emailTextField.text ?? "")
        if !emailTextField.text!.isEmpty {
            if !passwordTextField.text!.isEmpty {
                if isValid {
                    if btnMark.currentBackgroundImage == UIImage(named: "mark") && btn1.alpha == 1 {
                        let alertError = UIAlertController(title: "RememberData".localize(), message: nil, preferredStyle: .alert)
                        alertError.addAction(UIAlertAction(title: "Yes".localize(), style: .default, handler: { [self](action: UIAlertAction!) in
                            UserDefaults.standard.set(emailTextField.text, forKey: UserData.SettingsKeys.login.rawValue)
                            UserDefaults.standard.set(true, forKey: UserData.SettingsKeys.showedAuth.rawValue)
                            let vc = TabBarController()
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: false)
                            UserDefaults.standard.set(self.emailTextField.text, forKey: UserData.SettingsKeys.login.rawValue)
                        }))
                        alertError.addAction(UIAlertAction(title: "No".localize(), style: .default, handler: {(action: UIAlertAction!) in
                            let vc = TabBarController()
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: false)
                        }))
                        present(alertError, animated: true)
                    } else {
                        btn1.alpha = 0.5
                    }
                }
            } else {
                let alertError = UIAlertController(title: "Error".localize(), message: "Invalid password".localize(), preferredStyle: .alert)
                alertError.addAction(UIAlertAction(title: "ОК", style: .default))
                present(alertError, animated: true)
            }
        } else {
            let alertError = UIAlertController(title: "Error".localize(), message: "Invalid email".localize(), preferredStyle: .alert)
            alertError.addAction(UIAlertAction(title: "ОК", style: .default))
            present(alertError, animated: true)
        }
    }

    @objc func doneButtonAction() {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }

    @objc func switchAction() {
        switch (indexSwitch) {
        case false:
            labelTitle.text = "title.create".localize()
            btn1.setTitle("title.create".localize(), for: .normal)
            btnSwitch.setTitle("Sign in".localize(), for: .normal)
            lblNoAccount.text = "haveAcc".localize()
            btnMark.isHidden = false
            lblConfirm.isHidden = false
            lblForgot.isHidden = true
            lblTerms.isHidden = false
            lblPolicy.isHidden = false
            lblTempFirst.isHidden = false
            lblTempSecond.isHidden = false
            lblAdult.isHidden = false

            indexSwitch = true
        case true:
            labelTitle.text = "title.login".localize()
            btn1.setTitle("Sign in".localize(), for: .normal)
            btnSwitch.setTitle("createAcc".localize(), for: .normal)
            lblNoAccount.text = "noAcc".localize()
            btnMark.isHidden = true
            lblConfirm.isHidden = true
            lblForgot.isHidden = false
            lblTerms.isHidden = true
            lblPolicy.isHidden = true
            lblTempFirst.isHidden = true
            lblTempSecond.isHidden = true
            lblAdult.isHidden = true

            indexSwitch = false
        }
    }
}
