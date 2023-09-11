import UIKit

final class RobotController: UIViewController {
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.text = "tabbar.robot".localize()
        view.font = .systemFont(ofSize: 18, weight: .bold)
        view.textAlignment = .center
        return view
    }()

    private lazy var nextButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = UIColor(red: 0.913, green: 0.283, blue: 0.158, alpha: 1)
        view.layer.cornerRadius = 6
        view.setTitleColor(.white, for: .normal)
        view.setTitle("Stop the robot".localize(), for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 13, weight: .bold)
        view.addTarget(self, action: #selector(stopRobot), for: .touchUpInside)
        return view
    }()

    private let viewCancel: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.165, green: 0.169, blue: 0.188, alpha: 1)
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        view.isHidden = true
        return view
    }()

    private let imgOption: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "imgOption")
        view.contentMode = .scaleAspectFit
        return view
    }()

    private lazy var imgClose: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "imgClose")
        view.contentMode = .scaleAspectFit
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(cancelRobot)))
        return view
    }()


    private let optionLbl: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.font = .systemFont(ofSize: 18, weight: .bold)
        view.textAlignment = .center
        view.text = "doneBot".localize()
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        return view
    }()

    private lazy var confirmButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = UIColor(red: 0.95, green: 0.32, blue: 0.19, alpha: 1)
        view.layer.cornerRadius = 6
        view.setTitleColor(.white, for: .normal)
        view.setTitle("Confirm".localize(), for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 13, weight: .bold)
        view.addTarget(self, action: #selector(goResult), for: .touchUpInside)
        return view
    }()

    private lazy var cancelButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = UIColor(red: 0.26, green: 0.276, blue: 0.33, alpha: 1)
        view.layer.cornerRadius = 6
        view.setTitleColor(.white, for: .normal)
        view.setTitle("Cancel".localize(), for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 13, weight: .bold)
        view.addTarget(self, action: #selector(cancelRobot), for: .touchUpInside)
        return view
    }()

    private let balanceLabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.font = .systemFont(ofSize: 34, weight: .bold)
        view.textAlignment = .left
        return view
    }()

    private let profitLabel: UILabel = {
        let view = UILabel()
        view.textColor = UIColor(red: 0.584, green: 0.612, blue: 0.663, alpha: 1)
        view.text = "Profit:".localize()
        view.font = .systemFont(ofSize: 13, weight: .regular)
        view.textAlignment = .left
        return view
    }()

    private let profitLabelVal: UILabel = {
        let view = UILabel()
        view.textColor = UIColor(red: 0.125, green: 0.745, blue: 0.455, alpha: 1)
        view.font = .systemFont(ofSize: 13, weight: .regular)
        view.textAlignment = .left
        return view
    }()

    private let imgIcon: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "iconBino")
        view.contentMode = .scaleAspectFit
        return view
    }()

    private var viewForItems1: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.26, green: 0.276, blue: 0.33, alpha: 1)
        view.layer.cornerRadius = 12
        return view
    }()

    private var viewForItems2: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.26, green: 0.276, blue: 0.33, alpha: 1)
        view.layer.cornerRadius = 12
        return view
    }()

    private let imgIcon1 = UIImageView(image: UIImage(named: "status 1"))
    private let imgIcon2 = UIImageView(image: UIImage(named: "alarm"))
    private let imgIcon3 = UIImageView(image: UIImage(named: "exchange"))
    private let imgIcon4 = UIImageView(image: UIImage(named: "coin"))
    private let imgIcon5 = UIImageView(image: UIImage(named: "strategy"))
    private let imgIcon6 = UIImageView(image: UIImage(named: "indi"))
    private let imgIcon7 = UIImageView(image: UIImage(named: "risk"))
    private let imgIcon8 = UIImageView(image: UIImage(named: "alarm"))

    private let itemTitle1: UILabel = {
        let view = UILabel()
        view.textColor = UIColor(red: 0.584, green: 0.612, blue: 0.663, alpha: 1)
        view.text = "Status".localize()
        view.font = .systemFont(ofSize: 13, weight: .regular)
        view.textAlignment = .left
        return view
    }()

    private let itemTitle2: UILabel = {
        let view = UILabel()
        view.textColor = UIColor(red: 0.584, green: 0.612, blue: 0.663, alpha: 1)
        view.text = "Expired in".localize()
        view.font = .systemFont(ofSize: 13, weight: .regular)
        view.textAlignment = .left
        return view
    }()

    private let itemTitle3: UILabel = {
        let view = UILabel()
        view.textColor = UIColor(red: 0.584, green: 0.612, blue: 0.663, alpha: 1)
        view.text = "Trading asset".localize()
        view.font = .systemFont(ofSize: 13, weight: .regular)
        view.textAlignment = .left
        return view
    }()

    private let itemTitle4: UILabel = {
        let view = UILabel()
        view.textColor = UIColor(red: 0.584, green: 0.612, blue: 0.663, alpha: 1)
        view.text = "Amount".localize()
        view.font = .systemFont(ofSize: 13, weight: .regular)
        view.textAlignment = .left
        return view
    }()

    private let itemTitle5: UILabel = {
        let view = UILabel()
        view.textColor = UIColor(red: 0.584, green: 0.612, blue: 0.663, alpha: 1)
        view.text = "Strategy".localize()
        view.font = .systemFont(ofSize: 13, weight: .regular)
        view.textAlignment = .left
        return view
    }()

    private let itemTitle6: UILabel = {
        let view = UILabel()
        view.textColor = UIColor(red: 0.584, green: 0.612, blue: 0.663, alpha: 1)
        view.text = "Indicators".localize()
        view.font = .systemFont(ofSize: 13, weight: .regular)
        view.textAlignment = .left
        return view
    }()

    private let itemTitle7: UILabel = {
        let view = UILabel()
        view.textColor = UIColor(red: 0.584, green: 0.612, blue: 0.663, alpha: 1)
        view.text = "Risk management".localize()
        view.font = .systemFont(ofSize: 13, weight: .regular)
        view.textAlignment = .left
        return view
    }()

    private let itemTitle8: UILabel = {
        let view = UILabel()
        view.textColor = UIColor(red: 0.584, green: 0.612, blue: 0.663, alpha: 1)
        view.text = "Profit limit".localize()
        view.font = .systemFont(ofSize: 13, weight: .regular)
        view.textAlignment = .left
        return view
    }()

    private let itemVal1: UILabel = {
        let view = UILabel()
        view.textColor = UIColor(red: 1, green: 0.855, blue: 0.267, alpha: 1)
        view.text = "Searching".localize()
        view.font = .systemFont(ofSize: 13, weight: .bold)
        view.textAlignment = .right
        return view
    }()

    private let itemVal2: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.text = "00:59"
        view.font = .systemFont(ofSize: 13, weight: .bold)
        view.textAlignment = .right
        return view
    }()

    private let itemVal3: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.text = "EUR/USD"
        view.font = .systemFont(ofSize: 13, weight: .bold)
        view.textAlignment = .right
        return view
    }()

    private let itemVal4: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.text = "Đ10"
        view.font = .systemFont(ofSize: 13, weight: .bold)
        view.textAlignment = .right
        return view
    }()

    private let itemVal5: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.text = "Auto".localize()
        view.font = .systemFont(ofSize: 13, weight: .bold)
        view.textAlignment = .right
        return view
    }()

    private let itemVal6: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.text = "ai".localize()
        view.font = .systemFont(ofSize: 13, weight: .bold)
        view.textAlignment = .right
        return view
    }()

    private let itemVal7: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.text = "Optimal".localize()
        view.font = .systemFont(ofSize: 13, weight: .bold)
        view.textAlignment = .right
        return view
    }()

    private let itemVal8: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.text = "Đ20"
        view.font = .systemFont(ofSize: 13, weight: .bold)
        view.textAlignment = .right
        return view
    }()

    private let viewDark: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.078, green: 0.11, blue: 0.157, alpha: 0.6)
        view.isHidden = true
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = UIColor(red: 0.165, green: 0.169, blue: 0.188, alpha: 1)

        setupUI()
    }
}

private extension RobotController {
    private func setupUI() {
        view.addSubviews(titleLabel, nextButton, balanceLabel, profitLabel, profitLabelVal, imgIcon, viewForItems1, viewForItems2, viewDark, viewCancel)
        viewCancel.addSubviews(imgClose, imgOption, optionLbl, cancelButton, confirmButton)
        viewForItems1.addSubviews(imgIcon1, imgIcon2, imgIcon3, imgIcon4, itemTitle1, itemTitle2, itemTitle3, itemTitle4, itemVal1, itemVal2, itemVal3, itemVal4)
        viewForItems2.addSubviews(imgIcon5, imgIcon6, imgIcon7, imgIcon8, itemTitle5, itemTitle6, itemTitle7, itemTitle8, itemVal5, itemVal6, itemVal7, itemVal8)

        viewDark.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        viewForItems1.snp.makeConstraints { make in
            make.top.equalTo(profitLabel.snp.bottom).offset(24)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(itemVal4.snp.bottom).offset(13)
        }

        imgIcon1.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(13)
            make.height.width.equalTo(20)
        }

        imgIcon2.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(13)
            make.top.equalTo(imgIcon1.snp.bottom).offset(14)
            make.height.width.equalTo(20)
        }

        imgIcon3.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(13)
            make.top.equalTo(imgIcon2.snp.bottom).offset(14)
            make.height.width.equalTo(20)
        }

        imgIcon4.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(13)
            make.top.equalTo(imgIcon3.snp.bottom).offset(14)
            make.height.width.equalTo(20)
        }

        itemTitle1.snp.makeConstraints { make in
            make.leading.equalTo(imgIcon1.snp.trailing).offset(6)
            make.centerY.equalTo(imgIcon1.snp.centerY)
        }

        itemTitle2.snp.makeConstraints { make in
            make.leading.equalTo(imgIcon2.snp.trailing).offset(6)
            make.centerY.equalTo(imgIcon2.snp.centerY)
        }

        itemTitle3.snp.makeConstraints { make in
            make.leading.equalTo(imgIcon3.snp.trailing).offset(6)
            make.centerY.equalTo(imgIcon3.snp.centerY)
        }

        itemTitle4.snp.makeConstraints { make in
            make.leading.equalTo(imgIcon4.snp.trailing).offset(6)
            make.centerY.equalTo(imgIcon4.snp.centerY)
        }

        itemVal1.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-13)
            make.centerY.equalTo(imgIcon1.snp.centerY)
        }

        itemVal2.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-13)
            make.centerY.equalTo(imgIcon2.snp.centerY)
        }

        itemVal3.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-13)
            make.centerY.equalTo(imgIcon3.snp.centerY)
        }

        itemVal4.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-13)
            make.centerY.equalTo(imgIcon4.snp.centerY)
        }

        viewForItems2.snp.makeConstraints { make in
            make.top.equalTo(viewForItems1.snp.bottom).offset(16)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(itemVal8.snp.bottom).offset(13)
        }

        imgIcon5.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(13)
            make.height.width.equalTo(20)
        }

        imgIcon6.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(13)
            make.top.equalTo(imgIcon5.snp.bottom).offset(14)
            make.height.width.equalTo(20)
        }

        imgIcon7.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(13)
            make.top.equalTo(imgIcon6.snp.bottom).offset(14)
            make.height.width.equalTo(20)
        }

        imgIcon8.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(13)
            make.top.equalTo(imgIcon7.snp.bottom).offset(14)
            make.height.width.equalTo(20)
        }

        itemTitle5.snp.makeConstraints { make in
            make.leading.equalTo(imgIcon5.snp.trailing).offset(6)
            make.centerY.equalTo(imgIcon5.snp.centerY)
        }

        itemTitle6.snp.makeConstraints { make in
            make.leading.equalTo(imgIcon6.snp.trailing).offset(6)
            make.centerY.equalTo(imgIcon6.snp.centerY)
        }

        itemTitle7.snp.makeConstraints { make in
            make.leading.equalTo(imgIcon7.snp.trailing).offset(6)
            make.centerY.equalTo(imgIcon7.snp.centerY)
        }

        itemTitle8.snp.makeConstraints { make in
            make.leading.equalTo(imgIcon8.snp.trailing).offset(6)
            make.centerY.equalTo(imgIcon8.snp.centerY)
        }

        itemVal5.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-13)
            make.centerY.equalTo(imgIcon5.snp.centerY)
        }

        itemVal6.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-13)
            make.centerY.equalTo(imgIcon6.snp.centerY)
        }

        itemVal7.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-13)
            make.centerY.equalTo(imgIcon7.snp.centerY)
        }

        itemVal8.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-13)
            make.centerY.equalTo(imgIcon8.snp.centerY)
        }

        balanceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
        }

        profitLabel.snp.makeConstraints { make in
            make.top.equalTo(balanceLabel.snp.bottom).offset(8)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
        }

        profitLabelVal.snp.makeConstraints { make in
            make.top.equalTo(balanceLabel.snp.bottom).offset(8)
            make.leading.equalTo(profitLabel.snp.trailing).offset(4)
        }

        imgIcon.snp.makeConstraints { make in
            make.top.equalTo(balanceLabel.snp.top)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
            make.height.width.equalTo(66)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(5)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
        }

        nextButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-5)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.width.equalTo(50)
        }

        viewCancel.snp.makeConstraints { make in
            make.top.equalTo(imgClose.snp.top).offset(-28)
            make.bottom.trailing.leading.equalToSuperview()
        }

        cancelButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalTo(viewCancel.snp.centerX).offset(-5.5)
            make.height.equalTo(50)
        }

        confirmButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.trailing.equalToSuperview().offset(-16)
            make.leading.equalTo(viewCancel.snp.centerX).offset(5.5)
            make.height.equalTo(50)
        }

        optionLbl.snp.makeConstraints { make in
            make.bottom.equalTo(confirmButton.snp.top).offset(-16)
            make.trailing.leading.equalToSuperview().inset(16)
        }

        imgOption.snp.makeConstraints { make in
            make.bottom.equalTo(optionLbl.snp.top).offset(-8)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(40)
        }

        imgClose.snp.makeConstraints { make in
            make.bottom.equalTo(imgOption.snp.top).offset(-12)
            make.trailing.equalToSuperview().inset(16)
            make.height.width.equalTo(24)
        }
    }
}

private extension RobotController {
    @objc func goResult() {
        let vc = ResultController()
        navigationController?.pushViewController(vc, animated: false)
    }

    @objc func stopRobot() {
        viewCancel.isHidden = false
        viewDark.isHidden = false
    }

    @objc func cancelRobot() {
        viewCancel.isHidden = true
        viewDark.isHidden = true
    }
}
