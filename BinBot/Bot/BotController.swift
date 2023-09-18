import UIKit

class BotController: UIViewController, UIScrollViewDelegate {
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        scrollView.backgroundColor = .clear
        scrollView.showsVerticalScrollIndicator = false
        scrollView.isUserInteractionEnabled = true

        return scrollView
    }()

    private let titleLabel: UILabel = {
        let labelTitle = UILabel()
        labelTitle.textColor = .white
        labelTitle.text = "tabbar.robot".localize()
        labelTitle.font = .systemFont(ofSize: 18, weight: .bold)
        labelTitle.textAlignment = .center
        
        return labelTitle
    }()

    private lazy var balanceView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.26, green: 0.276, blue: 0.33, alpha: 1)
        view.layer.cornerRadius = 12
        return view
    }()

    private let balanceTitleLabel: UILabel = {
        let view = UILabel()
        view.textColor = UIColor(red: 0.584, green: 0.612, blue: 0.663, alpha: 1)
        view.text = "trade.balance".localize()
        view.font = .systemFont(ofSize: 11, weight: .regular)
        return view
    }()

    private let balanceValueLabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.font = .systemFont(ofSize: 13, weight: .bold)
        return view
    }()

    private let imgBalance = UIImageView(image: UIImage(named: "righ"))

    private lazy var assetView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.26, green: 0.276, blue: 0.33, alpha: 1)
        view.layer.cornerRadius = 12
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapPair)))
        return view
    }()

    private let assetTitleLabel: UILabel = {
        let view = UILabel()
        view.textColor = UIColor(red: 0.584, green: 0.612, blue: 0.663, alpha: 1)
        view.text = "trade.choose".localize()
        view.font = .systemFont(ofSize: 11, weight: .regular)
        return view
    }()

    private let assetValueLabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.font = .systemFont(ofSize: 13, weight: .bold)
        view.text = "EUR/USD"
        return view
    }()

    private let imgAsset = UIImageView(image: UIImage(named: "righ"))

    private lazy var riskView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.26, green: 0.276, blue: 0.33, alpha: 1)
        view.layer.cornerRadius = 12
        return view
    }()

    private let riskTitleLabel: UILabel = {
        let view = UILabel()
        view.textColor = UIColor(red: 0.584, green: 0.612, blue: 0.663, alpha: 1)
        view.text = "Risk Management".localize()
        view.font = .systemFont(ofSize: 11, weight: .regular)
        return view
    }()

    private lazy var optimalView: UIButton = {
        let view = UIButton()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 0.584, green: 0.612, blue: 0.663, alpha: 1).cgColor
        view.addTarget(self, action: #selector(tapOnView), for: .touchUpInside)
        return view
    }()

    private lazy var aggressiveView: UIButton = {
        let view = UIButton()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 0.584, green: 0.612, blue: 0.663, alpha: 1).cgColor
        view.addTarget(self, action: #selector(tapOnView), for: .touchUpInside)
        return view
    }()

    private let optimalTitleLabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.text = "Optimal".localize()
        view.font = .systemFont(ofSize: 14, weight: .bold)
        return view
    }()

    private let aggressiveTitleLabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.text = "Aggressive".localize()
        view.font = .systemFont(ofSize: 14, weight: .bold)
        return view
    }()

    private let imgCheck1 = UIImageView(image: UIImage(named: "aggressive"))
    private let imgCheck2 = UIImageView(image: UIImage(named: "aggressive"))

    private let recommendLabel1: UILabel = {
        let view = UILabel()
        view.textColor = UIColor(red: 0.584, green: 0.612, blue: 0.663, alpha: 1)
        view.text = "recommend1".localize()
        view.font = .systemFont(ofSize: 11, weight: .regular)
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        return view
    }()

    private let recommendLabel2: UILabel = {
        let view = UILabel()
        view.textColor = UIColor(red: 0.584, green: 0.612, blue: 0.663, alpha: 1)
        view.text = "recommend2".localize()
        view.font = .systemFont(ofSize: 11, weight: .regular)
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        return view
    }()

    private lazy var profitView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.26, green: 0.276, blue: 0.33, alpha: 1)
        view.layer.cornerRadius = 12
        return view
    }()

    private let profitTitleLabel: UILabel = {
        let view = UILabel()
        view.textColor = UIColor(red: 0.584, green: 0.612, blue: 0.663, alpha: 1)
        view.text = "Profit limit".localize()
        view.font = .systemFont(ofSize: 11, weight: .regular)
        return view
    }()

    private lazy var switchControl: UISwitch = {
        var switchControl = UISwitch()
        switchControl.addTarget(self, action: #selector(switchAction), for: .valueChanged)
        return switchControl
    }()

    private lazy var profitLabel: UITextField = {
        let view = UITextField()
        view.textColor = .white
        view.text = "150"
        view.font = .systemFont(ofSize: 13, weight: .bold)
        view.keyboardType = .decimalPad
        view.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)

        return view
    }()

    private lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.584, green: 0.612, blue: 0.663, alpha: 1)
        return view
    }()

    private let stopBotLabel: UILabel = {
        let view = UILabel()
        view.textColor = UIColor(red: 0.584, green: 0.612, blue: 0.663, alpha: 1)
        view.text = "hourStop".localize()
        view.font = .systemFont(ofSize: 11, weight: .regular)
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        return view
    }()

    private lazy var imgQues: UIImageView = {
        var imgQues = UIImageView()
        imgQues.isUserInteractionEnabled = true
        imgQues.image = UIImage(named: "ques")
        imgQues.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapOnStrategy)))
        return imgQues
    }()

    private lazy var strategyView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.26, green: 0.276, blue: 0.33, alpha: 1)
        view.layer.cornerRadius = 12
        return view
    }()

    private let strategyLabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.text = "Trading Strategy".localize()
        view.font = .systemFont(ofSize: 18, weight: .bold)
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        return view
    }()

    private lazy var strategyTableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.isScrollEnabled = false
        view.register(StrategyCell.self, forCellReuseIdentifier: "StrategyCell")
        view.showsVerticalScrollIndicator = false
        view.backgroundColor = .clear
        view.dataSource = self
        view.delegate = self
        return view
    }()

    private lazy var btnStart: UIButton = {
        let view = UIButton()
        view.backgroundColor = UIColor(red: 1, green: 0.855, blue: 0.267, alpha: 1)
        view.layer.cornerRadius = 6
        view.setTitleColor(UIColor(red: 0.165, green: 0.169, blue: 0.188, alpha: 1), for: .normal)
        view.setTitle("Start trading".localize(), for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        view.addTarget(self, action: #selector(tapButtonNext), for: .touchUpInside)

        return view
    }()

    private let viewConfirm: UIView = {
        let line1 = UIView()
        line1.backgroundColor = UIColor(red: 0.165, green: 0.169, blue: 0.188, alpha: 1)
        line1.layer.cornerRadius = 20

        return line1
    }()

    private let viewForItems: UIView = {
        let line1 = UIView()
        line1.backgroundColor = UIColor(red: 0.26, green: 0.276, blue: 0.33, alpha: 1)
        line1.layer.cornerRadius = 10

        return line1
    }()

    private let line1: UIView = {
        let line1 = UIView()
        line1.backgroundColor = UIColor(red: 0.165, green: 0.169, blue: 0.188, alpha: 1)

        return line1
    }()

    private let line2: UIView = {
        let line1 = UIView()
        line1.backgroundColor = UIColor(red: 0.165, green: 0.169, blue: 0.188, alpha: 1)

        return line1
    }()

    private let line3: UIView = {
        let line1 = UIView()
        line1.backgroundColor = UIColor(red: 0.165, green: 0.169, blue: 0.188, alpha: 1)

        return line1
    }()

    private let conformationTitleLabel: UILabel = {
        let labelTitle = UILabel()
        labelTitle.textColor = .white
        labelTitle.text = "Conformation".localize()
        labelTitle.font = .systemFont(ofSize: 13, weight: .bold)
        labelTitle.textAlignment = .left

        return labelTitle
    }()

    private let strategyLblConfirm: UILabel = {
        let labelTitle = UILabel()
        labelTitle.textColor = .white
        labelTitle.text = "Trading asset".localize()
        labelTitle.font = .systemFont(ofSize: 13, weight: .regular)
        labelTitle.textAlignment = .left

        return labelTitle
    }()

    private let indicatorsLblConfirm: UILabel = {
        let labelTitle = UILabel()
        labelTitle.textColor = .white
        labelTitle.text = "Strategy".localize()
        labelTitle.font = .systemFont(ofSize: 13, weight: .regular)
        labelTitle.textAlignment = .left

        return labelTitle
    }()

    private let riskLblConfirm: UILabel = {
        let labelTitle = UILabel()
        labelTitle.textColor = .white
        labelTitle.text = "Risk management".localize()
        labelTitle.font = .systemFont(ofSize: 13, weight: .regular)
        labelTitle.textAlignment = .left

        return labelTitle
    }()

    private let profitLblConfirm: UILabel = {
        let labelTitle = UILabel()
        labelTitle.textColor = .white
        labelTitle.text = "Profit limit".localize()
        labelTitle.font = .systemFont(ofSize: 13, weight: .regular)
        labelTitle.textAlignment = .left

        return labelTitle
    }()

    private let strategyLblConfirmVal: UILabel = {
        let labelTitle = UILabel()
        labelTitle.textColor = .white
        labelTitle.text = "Auto".localize()
        labelTitle.font = .systemFont(ofSize: 13, weight: .semibold)
        labelTitle.textAlignment = .right

        return labelTitle
    }()

    private let indicatorsLblConfirmVal: UILabel = {
        let labelTitle = UILabel()
        labelTitle.textColor = .white
        labelTitle.text = "Custom".localize()
        labelTitle.font = .systemFont(ofSize: 13, weight: .semibold)
        labelTitle.textAlignment = .right

        return labelTitle
    }()

    private let riskLblConfirmVal: UILabel = {
        let labelTitle = UILabel()
        labelTitle.textColor = .white
        labelTitle.text = "Optimal".localize()
        labelTitle.font = .systemFont(ofSize: 13, weight: .semibold)
        labelTitle.textAlignment = .right

        return labelTitle
    }()

    private let profitLblConfirmVal: UILabel = {
        let labelTitle = UILabel()
        labelTitle.textColor = .white
        labelTitle.font = .systemFont(ofSize: 13, weight: .semibold)
        labelTitle.textAlignment = .right
        return labelTitle
    }()

    private let lastView: UIView = {
        let lastView = UIView()
        lastView.backgroundColor = .clear
        return lastView
    }()

    private lazy var confirmButton: UIButton = {
        let nextButton = UIButton()
        nextButton.backgroundColor = UIColor(red: 1, green: 0.855, blue: 0.267, alpha: 1)
        nextButton.layer.cornerRadius = 6
        nextButton.setTitleColor(UIColor(red: 0.165, green: 0.169, blue: 0.188, alpha: 1), for: .normal)
        nextButton.setTitle("Confirm".localize(), for: .normal)
        nextButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        nextButton.addTarget(self, action: #selector(goNext), for: .touchUpInside)

        return nextButton
    }()

    private lazy var close: UIImageView = {
        var view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.isUserInteractionEnabled = true
        view.image = UIImage(named: "cross")
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closePage)))
        return view
    }()

    private var arrayTtiles: [String] = ["Auto strategy".localize(), "Custom strategy".localize()]
    private var hiddenSections = Set<Int>()
    private var pair = BinBotContent.shared.pairs.first
    private var riskTopic = "Optimal".localize()
    private var titleTopic = "Auto".localize()

    private var topicsFirst: [[(String, String, UIImage?, UIImage?)]] = [
        [ ("Auto".localize(), "auto.desc".localize(), UIImage(named: "whiteCircle"), UIImage(named: "Auto"))],
        [
            ("MACD".localize(), "auto.desc".localize(), UIImage(named: "whiteCircle"), UIImage(named: "MACD")),
            ("Stochastic".localize(), "stochastic.desc".localize(), UIImage(named: "whiteCircle"), UIImage(named: "Stochastic")),
            ("Bollinger Bands".localize(), "bollinger.desc".localize(), UIImage(named: "whiteCircle"), UIImage(named: "Bollinger Bands")),
            ("RSI".localize(), "RSI.desc".localize(), UIImage(named: "whiteCircle"), UIImage(named: "RSI")),
            ("CCI".localize(), "CCI.desc".localize(), UIImage(named: "whiteCircle"), UIImage(named: "CCI")),
            ("Close price".localize(), "closeprice.desc".localize(), UIImage(named: "whiteCircle"), UIImage(named: "Close price"))
        ]
    ]

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        scrollView.layoutIfNeeded()
        scrollView.updateContentView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        balanceValueLabel.text = "Đ \(UserData.balance)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.165, green: 0.169, blue: 0.188, alpha: 1)
        navigationController?.navigationBar.isHidden = true
        scrollView.delegate = self
        tapOnView(optimalView)
        addDoneButtonOnKeyboard()

        view.addSubviews(titleLabel, scrollView, viewConfirm)
        scrollView.addSubviews(balanceView, assetView, riskView, profitView, strategyView, btnStart)
        balanceView.addSubviews(balanceTitleLabel, balanceValueLabel, imgBalance)
        assetView.addSubviews(assetTitleLabel, assetValueLabel, imgAsset)
        riskView.addSubviews(riskTitleLabel, optimalView, aggressiveView)
        optimalView.addSubviews(optimalTitleLabel, recommendLabel1, imgCheck1)
        aggressiveView.addSubviews(aggressiveTitleLabel, recommendLabel2, imgCheck2)
        profitView.addSubviews(profitTitleLabel, profitLabel, switchControl, lineView, stopBotLabel)
        strategyView.addSubviews(strategyLabel, strategyTableView, imgQues)
        viewConfirm.isHidden = true
        viewConfirm.addSubviews(viewForItems, close, confirmButton, conformationTitleLabel)
        viewForItems.addSubviews(line1, line2, line3, strategyLblConfirm, strategyLblConfirmVal, indicatorsLblConfirm, indicatorsLblConfirmVal, riskLblConfirm, riskLblConfirmVal, profitLblConfirm, profitLblConfirmVal)

        btnStart.snp.makeConstraints { make in
            make.top.equalTo(strategyView.snp.bottom).offset(12)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(50)
        }

        strategyView.snp.makeConstraints { make in
            make.top.equalTo(profitView.snp.bottom).offset(12)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(strategyTableView.snp.bottom).offset(12)
        }

        strategyLabel.snp.makeConstraints { make in
            make.top.equalTo(strategyView.snp.top).offset(12)
            make.leading.equalTo(strategyView.snp.leading).offset(12)
        }

        imgQues.snp.makeConstraints { make in
            make.top.equalTo(strategyView.snp.top).offset(12)
            make.trailing.equalTo(strategyView.snp.trailing).offset(-12)
            make.height.width.equalTo(24)
        }

        strategyTableView.snp.makeConstraints { make in
            make.top.equalTo(strategyView.snp.top).offset(12)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(32)
            make.height.equalTo(580)
        }

        stopBotLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(8)
            make.leading.equalTo(profitView.snp.leading).offset(16)
            make.trailing.equalTo(profitView.snp.trailing).offset(-16)
        }

        lineView.snp.makeConstraints { make in
            make.top.equalTo(switchControl.snp.bottom).offset(14)
            make.height.equalTo(0.5)
            make.leading.equalTo(profitView.snp.leading).offset(16)
            make.trailing.equalTo(profitView.snp.trailing).offset(-16)
        }

        profitLabel.snp.makeConstraints { make in
            make.top.equalTo(profitTitleLabel.snp.bottom).offset(4)
            make.leading.equalTo(profitView.snp.leading).offset(12)
        }

        profitView.snp.makeConstraints { make in
            make.top.equalTo(riskView.snp.bottom).offset(12)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(stopBotLabel.snp.bottom).offset(12)
        }

        profitTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(profitView.snp.top).offset(12)
            make.leading.equalTo(profitView.snp.leading).offset(12)
        }

        switchControl.snp.makeConstraints { make in
            make.top.equalTo(profitTitleLabel.snp.centerY)
            make.trailing.equalToSuperview().offset(-16)
            make.width.equalTo(52)
            make.height.equalTo(32)
        }

        recommendLabel2.snp.makeConstraints { make in
            make.top.equalTo(aggressiveTitleLabel.snp.bottom).offset(6)
            make.leading.equalTo(aggressiveView.snp.leading).offset(12)
            make.trailing.equalTo(aggressiveView.snp.trailing).offset(-10)
        }

        recommendLabel1.snp.makeConstraints { make in
            make.top.equalTo(optimalTitleLabel.snp.bottom).offset(6)
            make.leading.equalTo(optimalView.snp.leading).offset(12)
            make.trailing.equalTo(optimalView.snp.trailing).offset(-10)
        }

        aggressiveTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(imgCheck2.snp.trailing).offset(8)
            make.centerY.equalTo(imgCheck2.snp.centerY)
        }

        optimalTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(imgCheck1.snp.trailing).offset(8)
            make.centerY.equalTo(imgCheck1.snp.centerY)
        }

        imgCheck1.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(12)
            make.height.width.equalTo(20)
        }

        imgCheck2.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(12)
            make.height.width.equalTo(20)
        }

        optimalView.snp.makeConstraints { make in
            make.top.equalTo(riskTitleLabel.snp.bottom).offset(8)
            make.leading.equalTo(riskView.snp.leading).offset(12)
            make.trailing.equalTo(riskView.snp.centerX).offset(-4)
            make.bottom.equalTo(recommendLabel1.snp.bottom).offset(12)
        }

        aggressiveView.snp.makeConstraints { make in
            make.top.equalTo(riskTitleLabel.snp.bottom).offset(8)
            make.trailing.equalTo(riskView.snp.trailing).offset(-12)
            make.leading.equalTo(riskView.snp.centerX).offset(4)
            make.bottom.equalTo(recommendLabel1.snp.bottom).offset(12)
        }

        riskView.snp.makeConstraints { make in
            make.top.equalTo(assetView.snp.bottom).offset(12)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(optimalView.snp.bottom).offset(12)
        }

        riskTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(riskView.snp.top).offset(12)
            make.leading.equalTo(riskView.snp.leading).offset(12)
        }

        assetView.snp.makeConstraints { make in
            make.top.equalTo(balanceView.snp.bottom).offset(12)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(67)
        }

        assetTitleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(assetView.snp.centerY).offset(-8)
            make.leading.equalTo(assetView.snp.leading).offset(12)
        }

        assetValueLabel.snp.makeConstraints { make in
            make.top.equalTo(assetView.snp.centerY)
            make.leading.equalTo(assetView.snp.leading).offset(12)
        }

        imgAsset.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
            make.height.width.equalTo(24)
        }

        balanceView.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.top).offset(6)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(67)
        }

        balanceTitleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(balanceView.snp.centerY).offset(-8)
            make.leading.equalTo(balanceView.snp.leading).offset(12)
        }

        balanceValueLabel.snp.makeConstraints { make in
            make.top.equalTo(balanceView.snp.centerY)
            make.leading.equalTo(balanceView.snp.leading).offset(12)
        }

        imgBalance.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
            make.height.width.equalTo(24)
        }

        scrollView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(6)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
        }

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        confirmButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-20)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }

        viewForItems.snp.makeConstraints { make in
            make.bottom.equalTo(confirmButton.snp.top).offset(-16)
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.equalTo(strategyLblConfirm.snp.top).offset(-13)
        }

        profitLblConfirm.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-13)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalTo(viewConfirm.snp.centerX)
        }

        profitLblConfirmVal.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-13)
            make.trailing.equalToSuperview().inset(12)
            make.leading.equalTo(viewConfirm.snp.centerX)
        }

        line3.snp.makeConstraints { make in
            make.bottom.equalTo(profitLblConfirmVal.snp.top).offset(-13)
            make.height.equalTo(1)
            make.trailing.leading.equalToSuperview()
        }

        riskLblConfirm.snp.makeConstraints { make in
            make.bottom.equalTo(line3.snp.top).offset(-13)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalTo(viewConfirm.snp.centerX)
        }

        riskLblConfirmVal.snp.makeConstraints { make in
            make.bottom.equalTo(line3.snp.top).offset(-13)
            make.trailing.equalToSuperview().inset(12)
            make.leading.equalTo(viewConfirm.snp.centerX)
        }

        line2.snp.makeConstraints { make in
            make.bottom.equalTo(riskLblConfirmVal.snp.top).offset(-13)
            make.height.equalTo(1)
            make.trailing.leading.equalToSuperview()
        }

        indicatorsLblConfirm.snp.makeConstraints { make in
            make.bottom.equalTo(line2.snp.top).offset(-13)
            make.leading.equalToSuperview().offset(12)
//            make.trailing.equalTo(viewConfirm.snp.centerX)
            make.trailing.equalTo(indicatorsLblConfirmVal.snp.leading).offset(-5)
        }

        indicatorsLblConfirmVal.snp.makeConstraints { make in
            make.bottom.equalTo(line2.snp.top).offset(-13)
            make.trailing.equalToSuperview().inset(12)
            make.leading.equalTo(indicatorsLblConfirm.snp.trailing).offset(5)
//            make.leading.equalTo(viewConfirm.snp.centerX).offset(-80)
        }

        line1.snp.makeConstraints { make in
            make.bottom.equalTo(indicatorsLblConfirmVal.snp.top).offset(-13)
            make.height.equalTo(1)
            make.trailing.leading.equalToSuperview()
        }

        strategyLblConfirm.snp.makeConstraints { make in
            make.bottom.equalTo(line1.snp.top).offset(-13)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalTo(viewConfirm.snp.centerX)
        }

        strategyLblConfirmVal.snp.makeConstraints { make in
            make.bottom.equalTo(line1.snp.top).offset(-13)
            make.trailing.equalToSuperview().inset(12)
            make.leading.equalTo(viewConfirm.snp.centerX)
        }

        close.snp.makeConstraints { make in
            make.bottom.equalTo(viewForItems.snp.top).offset(-16)
            make.trailing.equalToSuperview().inset(16)
            make.height.width.equalTo(24)
        }

        conformationTitleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(close.snp.centerY)
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalTo(viewForItems.snp.top).offset(-11)
        }

        viewConfirm.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(15)
            make.top.equalTo(conformationTitleLabel.snp.top).offset(-16)
            make.leading.trailing.equalToSuperview()
        }
    }
}

extension BotController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StrategyCell", for: indexPath) as! StrategyCell
        cell.setup(data: topicsFirst[indexPath.section][indexPath.row], selected: topicsFirst[indexPath.section][indexPath.row].0 == titleTopic)
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.hiddenSections.contains(section) {
            return 0
        }
        return topicsFirst[section].count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return topicsFirst.count
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let verticalPadding: CGFloat = 8
        let maskLayer = CALayer()
        maskLayer.cornerRadius = 10
        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.frame = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cell.bounds.width, height: cell.bounds.height).insetBy(dx: 0, dy: verticalPadding/2)
        cell.layer.mask = maskLayer
    }
}

extension BotController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionButton = UIButton()
        for (ind, value) in arrayTtiles.enumerated() where section == ind {
            sectionButton.setTitle((value), for: .normal)
        }
        sectionButton.contentHorizontalAlignment = .left
        sectionButton.titleLabel?.font = .systemFont(ofSize: 11, weight: .regular)
        sectionButton.setTitleColor(UIColor(red: 0.584, green: 0.612, blue: 0.663, alpha: 1), for: .normal)
        sectionButton.backgroundColor = .clear
        sectionButton.tag = section
        sectionButton.addTarget(self, action: #selector(self.hideSection(sender:)), for: .touchUpInside)
        return sectionButton
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        titleTopic = topicsFirst[indexPath.section][indexPath.row].0
        tableView.deselectRow(at: indexPath, animated: false)
        tableView.reloadData()
    }
}

extension BotController {
    @objc private func tapButtonNext() {
        strategyLblConfirmVal.text = assetValueLabel.text!
        indicatorsLblConfirmVal.text = titleTopic
        riskLblConfirmVal.text = riskTopic
        switchControl.isOn ? (profitLblConfirmVal.text = profitLabel.text) : (profitLblConfirmVal.text = "Off".localize())
        viewConfirm.isHidden = false
    }

    @objc private func closePage() {
        viewConfirm.isHidden = true
    }

    @objc private func goNext(sender: UITapGestureRecognizer) {
        UserDefaults.standard.set(strategyLblConfirmVal.text, forKey: UserData.SettingsKeys.strategy.rawValue)
        UserDefaults.standard.set(profitLblConfirmVal.text, forKey: UserData.SettingsKeys.profit.rawValue)
        UserDefaults.standard.set(riskLblConfirmVal.text, forKey: UserData.SettingsKeys.risk.rawValue)
        UserDefaults.standard.set(assetValueLabel.text, forKey: UserData.SettingsKeys.pairVal.rawValue)

        //        viewAccount.isHidden = false
        viewConfirm.isHidden = true
        //        viewDark.isHidden = false
        //        activityIndicator.startAnimating()

        UserDefaults.standard.set(true, forKey: UserData.SettingsKeys.isWork.rawValue)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let vc = RobotController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    @objc private func tapOnStrategy() {
        let vc = StrategyController()
        navigationController?.pushViewController(vc, animated: false)
    }

    @objc func textFieldDidChange(_ textField: UITextField) {
        profitLabel.text = textField.text
    }

    @objc private func switchAction(sender: UISwitch) {
        sender.isOn ? (profitLabel.text = "150") : (profitLabel.text = "Off".localize())
    }

    @objc private func tapOnView(_ sender: UIButton) {
        switch (sender) {
        case optimalView:
            optimalView.backgroundColor = UIColor(red: 1, green: 0.855, blue: 0.267, alpha: 1)
            optimalView.layer.borderWidth = 0
            aggressiveView.backgroundColor = .clear
            aggressiveView.layer.borderWidth = 1
            optimalTitleLabel.textColor = UIColor(red: 0.165, green: 0.169, blue: 0.188, alpha: 1)
            aggressiveTitleLabel.textColor = .white
            recommendLabel1.textColor = UIColor(red: 0.165, green: 0.169, blue: 0.188, alpha: 1)
            recommendLabel2.textColor = UIColor(red: 0.584, green: 0.612, blue: 0.663, alpha: 1)
            imgCheck1.image = UIImage(named: "iconCheck1")
            imgCheck2.image = UIImage(named: "aggressive")
            riskTopic = optimalTitleLabel.text!
        case aggressiveView:
            aggressiveView.backgroundColor = UIColor(red: 1, green: 0.855, blue: 0.267, alpha: 1)
            aggressiveView.layer.borderWidth = 0
            optimalView.backgroundColor = .clear
            optimalView.layer.borderWidth = 1
            aggressiveTitleLabel.textColor = UIColor(red: 0.165, green: 0.169, blue: 0.188, alpha: 1)
            optimalTitleLabel.textColor = .white
            recommendLabel2.textColor = UIColor(red: 0.165, green: 0.169, blue: 0.188, alpha: 1)
            recommendLabel1.textColor = UIColor(red: 0.584, green: 0.612, blue: 0.663, alpha: 1)
            imgCheck2.image = UIImage(named: "iconCheck1")
            imgCheck1.image = UIImage(named: "aggressive")
            riskTopic = aggressiveTitleLabel.text!
        default: break
        }
    }

    @objc private func hideSection(sender: UIButton) {
        let section = sender.tag
        func indexPathsForSection() -> [IndexPath] {
            var indexPaths = [IndexPath]()
            for row in 0..<self.topicsFirst[section].count {
                indexPaths.append(IndexPath(row: row, section: section))
            }
            return indexPaths
        }

        if self.hiddenSections.contains(section) {
            self.hiddenSections.remove(section)
            self.strategyTableView.insertRows(at: indexPathsForSection(), with: .fade)
        } else {
            self.hiddenSections.insert(section)
            self.strategyTableView.deleteRows(at: indexPathsForSection(), with: .fade)
        }
    }

    @objc private func tapPair() {
        let vc = PairViewController()
        vc.pair = pair?.key
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: false)
    }

    func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done".localize(), style: .done, target: self, action: #selector(self.doneButtonAction))

        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()

        profitLabel.inputAccessoryView = doneToolbar
    }

    @objc func doneButtonAction() {
        if let text = profitLabel.text, let num = Int(text) {
            if num < 120 {
                profitLabel.text = "120"
            }
        }
        profitLabel.resignFirstResponder()
    }
}

extension BotController: PairDelegate {
    func updatePair(_ value: String?) {
        assetValueLabel.text = (value?.prefix(3))! + "/" + (value?.suffix(3))!
    }
}
