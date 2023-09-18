import UIKit

class ResultController: UIViewController {
    private let viewResult: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.26, green: 0.276, blue: 0.33, alpha: 1)
        view.layer.cornerRadius = 10
        return view
    }()

    private lazy var close: UIImageView = {
        var close = UIImageView()
        close.contentMode = .scaleAspectFit
        close.isUserInteractionEnabled = true
        close.image = UIImage(named: "closeRes")
        close.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closePage)))
        return close
    }()

    private lazy var nextBtn: UIButton = {
        var nextButton = UIButton()
        nextButton.backgroundColor = UIColor(red: 1, green: 0.855, blue: 0.267, alpha: 1)
        nextButton.layer.cornerRadius = 6
        nextButton.setTitleColor(UIColor(red: 0.165, green: 0.169, blue: 0.188, alpha: 1), for: .normal)
        nextButton.setTitle("Try on real account".localize(), for: .normal)
        nextButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        nextButton.addTarget(self, action: #selector(tapButtonNext), for: .touchUpInside)
        return nextButton
    }()

    private let lblNum: UILabel = {
        let view = UILabel()
        view.textColor = UIColor(red: 0.584, green: 0.612, blue: 0.663, alpha: 1)
        view.text = "Number of trades".localize()
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        view.font = .systemFont(ofSize: 13, weight: .regular)
        return view
    }()

    private let lblPercentage: UILabel = {
        let view = UILabel()
        view.textColor = UIColor(red: 0.584, green: 0.612, blue: 0.663, alpha: 1)
        view.text = "Percentage of profitable trades".localize()
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        view.font = .systemFont(ofSize: 13, weight: .regular)
        return view
    }()

    private let lblTotalProfit: UILabel = {
        let view = UILabel()
        view.textColor = UIColor(red: 0.584, green: 0.612, blue: 0.663, alpha: 1)
        view.text = "Total profit for the session".localize()
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        view.font = .systemFont(ofSize: 13, weight: .regular)
        return view
    }()

    private var lblNumVal: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.text = "100".localize()
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        view.font = .systemFont(ofSize: 13, weight: .bold)
        return view
    }()

    private let lblPercentageVal: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.text = "73%"
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        view.font = .systemFont(ofSize: 13, weight: .bold)
        return view
    }()

    private let lblTotalProfitVal: UILabel = {
        let view = UILabel()
        view.textColor = UIColor(red: 0.125, green: 0.745, blue: 0.455, alpha: 1)
        view.text = " 238 Đ"
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        view.font = .systemFont(ofSize: 23, weight: .bold)
        return view
    }()

    private let lblContinue: UnderlinedLabel = {
        let view = UnderlinedLabel()
        view.textColor =  UIColor(red: 1, green: 0.855, blue: 0.267, alpha: 1)
        view.text = "without.reg".localize()
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        view.font = .systemFont(ofSize: 11, weight: .regular)
        view.textAlignment = .center
        return view
    }()

    private let lblCongratulate: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.text = "congr".localize()
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        view.font = .systemFont(ofSize: 15, weight: .regular)
        view.textAlignment = .center
        return view
    }()

    private let resImg = UIImageView(image: UIImage(named: "result"))

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = UIColor(red: 0.165, green: 0.169, blue: 0.188, alpha: 1)
        close.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapButtonNext)))
        close.isUserInteractionEnabled = true
        view.addSubviews(close, viewResult, resImg, nextBtn, lblCongratulate, lblContinue)
        viewResult.addSubviews(lblNum, lblNumVal, lblPercentage, lblPercentageVal, lblTotalProfit, lblTotalProfitVal)

        nextBtn.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-5)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(50)
        }

        lblContinue.snp.makeConstraints { make in
            make.bottom.equalTo(nextBtn.snp.top).offset(-24)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
        }

        lblCongratulate.snp.makeConstraints { make in
            make.bottom.equalTo(lblContinue.snp.top).offset(-16)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
        }

        close.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.width.equalTo(24)
        }

        viewResult.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(12)
            make.bottom.equalTo(lblCongratulate.snp.top).offset(-50)
            make.top.equalTo(lblNumVal.snp.top).offset(-26)
        }

        resImg.snp.makeConstraints { make in
            make.bottom.equalTo(viewResult.snp.top).offset(-32)
            make.height.width.equalTo(99)
            make.centerX.equalToSuperview()
        }

        lblTotalProfit.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-26)
            make.leading.equalToSuperview().inset(14)
        }

        lblTotalProfitVal.snp.makeConstraints { make in
            make.centerY.equalTo(lblTotalProfit.snp.centerY)
            make.trailing.equalToSuperview().inset(14)
        }

        lblPercentage.snp.makeConstraints { make in
            make.bottom.equalTo(lblTotalProfitVal.snp.top).offset(-14)
            make.leading.equalToSuperview().inset(14)
        }

        lblPercentageVal.snp.makeConstraints { make in
            make.bottom.equalTo(lblTotalProfitVal.snp.top).offset(-14)
            make.trailing.equalToSuperview().inset(14)
        }

        lblNum.snp.makeConstraints { make in
            make.bottom.equalTo(lblPercentageVal.snp.top).offset(-14)
            make.leading.equalToSuperview().inset(14)
        }

        lblNumVal.snp.makeConstraints { make in
            make.bottom.equalTo(lblPercentageVal.snp.top).offset(-14)
            make.trailing.equalToSuperview().inset(14)
        }
    }
}

extension ResultController {
    @objc private func tapButtonNext() {
        UserDefaults.standard.set(nil, forKey: UserData.SettingsKeys.dateAlgorithmStart.rawValue)
        UserDefaults.standard.set(0, forKey: UserData.SettingsKeys.profitAfterActive.rawValue)
        UserDefaults.standard.set(0, forKey: UserData.SettingsKeys.sumProfitAfterActive.rawValue)

        self.navigationController?.popToRootViewController(animated: true)
    }

    @objc private func closePage() {
        UserDefaults.standard.set(nil, forKey: UserData.SettingsKeys.dateAlgorithmStart.rawValue)
        UserDefaults.standard.set(false, forKey: UserData.SettingsKeys.isWork.rawValue)
        UserDefaults.standard.set(0, forKey: UserData.SettingsKeys.profitAfterActive.rawValue)
        
        self.navigationController?.popToRootViewController(animated: true)
    }
}
