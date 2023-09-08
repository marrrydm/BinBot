import UIKit

class DepositController: UIViewController {
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Deposit".localize()
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .left

        return titleLabel
    }()

    private lazy var leftBarButton: UIImageView = {
        let leftBarButton = UIImageView()
        leftBarButton.image = UIImage(named: "close")
        leftBarButton.isUserInteractionEnabled = true
        leftBarButton.contentMode = .scaleAspectFit
        leftBarButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didLeftBarButtonTapped)))

        return leftBarButton
    }()

    private lazy var btnRegistration: UIButton = {
        let view = UIButton()
        view.backgroundColor = UIColor(red: 1, green: 0.855, blue: 0.267, alpha: 1)
        view.layer.cornerRadius = 6
        view.setTitleColor(UIColor(red: 0.165, green: 0.169, blue: 0.188, alpha: 1), for: .normal)
        view.setTitle("Registration".localize(), for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        view.addTarget(self, action: #selector(tapButtonNext), for: .touchUpInside)

        return view
    }()

    private let registrationLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "reg.description".localize()
        titleLabel.font = .systemFont(ofSize: 15, weight: .regular)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping

        return titleLabel
    }()

    private let demoLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Demo account".localize()
        titleLabel.font = .systemFont(ofSize: 11, weight: .regular)
        titleLabel.textColor = UIColor(red: 0.584, green: 0.612, blue: 0.663, alpha: 1)
        titleLabel.textAlignment = .left

        return titleLabel
    }()

    private let balanceLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 13, weight: .bold)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .left

        return titleLabel
    }()

    private var globalImg: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "global")
        view.contentMode = .scaleAspectFit
        return view
    }()

    private var updateImg: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "update")
        view.contentMode = .scaleAspectFit
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(updateBalance)))
        return view
    }()

    private let viewSelected: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 0.176, green: 0.275, blue: 0.392, alpha: 1).cgColor
        return view
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        balanceLabel.text = "\(UserData.balance) Đ"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = UIColor(red: 0.165, green: 0.169, blue: 0.188, alpha: 1)
        view.addSubviews(titleLabel, leftBarButton, btnRegistration, viewSelected)
        viewSelected.addSubviews(registrationLabel, demoLabel, balanceLabel, globalImg, updateImg)

        viewSelected.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(54)
        }

        globalImg.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.height.width.equalTo(24)
        }

        updateImg.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(16)
            make.height.width.equalTo(24)
        }

        demoLabel.snp.makeConstraints { make in
            make.bottom.equalTo(globalImg.snp.centerY).offset(-3)
            make.leading.equalTo(globalImg.snp.trailing).offset(12)
        }

        balanceLabel.snp.makeConstraints { make in
            make.top.equalTo(globalImg.snp.centerY)
            make.leading.equalTo(globalImg.snp.trailing).offset(12)
        }

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        leftBarButton.translatesAutoresizingMaskIntoConstraints = false
        leftBarButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
        leftBarButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
        leftBarButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        leftBarButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true

        btnRegistration.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }

        registrationLabel.snp.makeConstraints { make in
            make.bottom.equalTo(btnRegistration.snp.top).offset(-13)
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }

    @objc private func updateBalance() {
        //
    }

    @objc private func tapButtonNext() {
        //
    }

    @objc private func didLeftBarButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: false)
    }
}
