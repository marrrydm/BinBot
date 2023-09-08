import UIKit
import WebKit

class PlatformController: UIViewController, UITextFieldDelegate {
    private lazy var chart = WKWebView()

    private lazy var labelBalance: UITextField = {
        let view = UITextField()
        view.text = "\(UserData.balance)"
        view.textAlignment = .left
        view.keyboardType = .decimalPad
        view.textColor = .white
        view.font = .systemFont(ofSize: 18, weight: .bold)
        return view
    }()

    private let titleBalance: UILabel = {
        let view = UILabel()
        view.textAlignment = .left
        view.textColor = UIColor(red: 0.584, green: 0.612, blue: 0.663, alpha: 1)
        view.font = .systemFont(ofSize: 11, weight: .regular)
        view.text = "trade.balance".localize()
        return view
    }()

    private lazy var imgDeposit: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "add")
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapDeposit)))
        return view
    }()

    private lazy var assetView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.backgroundColor = UIColor(red: 0.26, green: 0.276, blue: 0.33, alpha: 1)
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapPair)))

        return view
    }()

    private let tradingAssetTitle: UILabel = {
        let view = UILabel()
        view.textAlignment = .left
        view.textColor = UIColor(red: 0.525, green: 0.533, blue: 0.58, alpha: 1)
        view.font = .systemFont(ofSize: 13, weight: .regular)
        view.text = "trade.choose".localize()
        return view
    }()

    private lazy var pairLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .left
        view.textColor = .white
        view.font = .systemFont(ofSize: 13, weight: .bold)
        return view
    }()

    private lazy var imgArrowRight: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "rightTrade")
        view.contentMode = .scaleAspectFit
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapPair)))
        return view
    }()

    private let investment: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.backgroundColor = UIColor(red: 0.26, green: 0.276, blue: 0.33, alpha: 1)
        return view
    }()

    private let investmentVal: UITextField = {
        let view = UITextField()
        view.textAlignment = .center
        view.isUserInteractionEnabled = false
        view.keyboardType = .numbersAndPunctuation
        view.textColor = .white
        view.font = .systemFont(ofSize: 16, weight: .semibold)
        view.text = "100"
        return view
    }()

    private let investmentTitle: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.textColor = UIColor(red: 0.525, green: 0.533, blue: 0.58, alpha: 1)
        view.font = .systemFont(ofSize: 13, weight: .regular)
        view.text = "Amount".localize()
        return view
    }()

    private lazy var plusInv: UIButton = {
        let view = UIButton()
        view.isUserInteractionEnabled = true
        view.setImage(UIImage(named: "plus"), for: .normal)
        view.addTarget(self, action: #selector(tapPlusMinus), for: .touchUpInside)
        return view
    }()

    private lazy var minusInv: UIButton = {
        let view = UIButton()
        view.isUserInteractionEnabled = true
        view.setImage(UIImage(named: "minus"), for: .normal)
        view.addTarget(self, action: #selector(tapPlusMinus), for: .touchUpInside)
        return view
    }()

    private lazy var sellView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 6
        view.backgroundColor = UIColor(red: 0.95, green: 0.32, blue: 0.19, alpha: 1)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(sellAction)))
        view.isUserInteractionEnabled = true
        return view
    }()

    private let sellLbl: UILabel = {
        let view = UILabel()
        view.textAlignment = .left
        view.textColor = .white
        view.font = .systemFont(ofSize: 14, weight: .bold)
        view.text = "trade.down".localize()
        return view
    }()

    private let sellImg: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "downImg")
        return view
    }()

    private lazy var buyView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.12, green: 0.75, blue: 0.46, alpha: 1)
        view.layer.cornerRadius = 6
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(buyAction)))
        view.isUserInteractionEnabled = true
        return view
    }()

    private let buyLbl: UILabel = {
        let view = UILabel()
        view.textAlignment = .left
        view.textColor = .white
        view.font = .systemFont(ofSize: 14, weight: .bold)
        view.text = "trade.up".localize()
        return view
    }()

    private let buyImg: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "upImg")
        return view
    }()

    private lazy var chartView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.165, green: 0.169, blue: 0.188, alpha: 1)
        return view
    }()

    private var pair = BinBotContent.shared.pairs.first
    private var initialState = true
    private var timer: Timer?
    private var price = 0.0
    private var invValue = 100.0

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.165, green: 0.169, blue: 0.188, alpha: 1)
        navigationController?.navigationBar.isHidden = true

        setupViews()
        makeConstraints()

        addDoneButtonOnKeyboard()

        labelBalance.text = "\(UserData.balance)"
        guard let pair = pair else { return }
        pairLabel.text = pair.key.prefix(3) + "/" + pair.key.suffix(3)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if initialState, let pair = pair {
            let content = TradingView(width: chart.frame.width - 20.0, height: chart.frame.height, symbol: pair.0).getHTMLContent()
            chart.loadHTMLString(content, baseURL: nil)
            initialState = false
        }

        if timer == nil {
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
                guard let self = self, let pair = self.pair else {
                    timer.invalidate()
                    return
                }

                let sign = Bool.random() ? 1.0 : -1.0
                self.price = pair.1 + pair.1 * Double.random(in: 0.0 ..< 0.0029) * sign
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UserDefaults.standard.set(true, forKey: UserData.SettingsKeys.showedTrade.rawValue)
        labelBalance.text = "\(UserData.balance) Đ"
    }

    private func setupViews() {
        view.addSubviews(chart, chartView)
        view.addSubviews(titleBalance, investment, sellView, buyView, labelBalance, assetView, imgDeposit)
        investment.addSubviews(investmentVal, plusInv, minusInv, investmentTitle)
        sellView.addSubviews(sellLbl, sellImg)
        buyView.addSubviews(buyLbl, buyImg)
        assetView.addSubviews(tradingAssetTitle, pairLabel, imgArrowRight)
    }

    private func makeConstraints() {
        sellView.translatesAutoresizingMaskIntoConstraints = false
        sellView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        sellView.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -2).isActive = true
        sellView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15).isActive = true
        sellView.heightAnchor.constraint(equalToConstant: 54).isActive = true

        sellImg.translatesAutoresizingMaskIntoConstraints = false
        sellImg.centerYAnchor.constraint(equalTo: sellView.centerYAnchor).isActive = true
        sellImg.trailingAnchor.constraint(equalTo: sellView.trailingAnchor, constant: -17).isActive = true
        sellImg.widthAnchor.constraint(equalToConstant: 22).isActive = true
        sellImg.heightAnchor.constraint(equalToConstant: 22).isActive = true

        sellLbl.translatesAutoresizingMaskIntoConstraints = false
        sellLbl.centerYAnchor.constraint(equalTo: sellView.centerYAnchor).isActive = true
        sellLbl.trailingAnchor.constraint(equalTo: sellView.trailingAnchor, constant: -30).isActive = true
        sellLbl.leadingAnchor.constraint(equalTo: sellView.leadingAnchor, constant: 16).isActive = true

        buyView.translatesAutoresizingMaskIntoConstraints = false
        buyView.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 2).isActive = true
        buyView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        buyView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15).isActive = true
        buyView.heightAnchor.constraint(equalToConstant: 54).isActive = true

        buyImg.translatesAutoresizingMaskIntoConstraints = false
        buyImg.centerYAnchor.constraint(equalTo: buyView.centerYAnchor).isActive = true
        buyImg.trailingAnchor.constraint(equalTo: buyView.trailingAnchor, constant: -17).isActive = true
        buyImg.widthAnchor.constraint(equalToConstant: 22).isActive = true
        buyImg.heightAnchor.constraint(equalToConstant: 22).isActive = true

        buyLbl.translatesAutoresizingMaskIntoConstraints = false
        buyLbl.centerYAnchor.constraint(equalTo: buyView.centerYAnchor).isActive = true
        buyLbl.trailingAnchor.constraint(equalTo: buyView.trailingAnchor, constant: -30).isActive = true
        buyLbl.leadingAnchor.constraint(equalTo: buyView.leadingAnchor, constant: 16).isActive = true

        plusInv.translatesAutoresizingMaskIntoConstraints = false
        plusInv.centerYAnchor.constraint(equalTo: investment.centerYAnchor).isActive = true
        plusInv.trailingAnchor.constraint(equalTo: investment.trailingAnchor, constant: -20).isActive = true
        plusInv.widthAnchor.constraint(equalToConstant: 32).isActive = true
        plusInv.heightAnchor.constraint(equalToConstant: 32).isActive = true

        minusInv.translatesAutoresizingMaskIntoConstraints = false
        minusInv.centerYAnchor.constraint(equalTo: investment.centerYAnchor).isActive = true
        minusInv.leadingAnchor.constraint(equalTo: investment.leadingAnchor, constant: 20).isActive = true
        minusInv.widthAnchor.constraint(equalToConstant: 32).isActive = true
        minusInv.heightAnchor.constraint(equalToConstant: 32).isActive = true

        investment.translatesAutoresizingMaskIntoConstraints = false
        investment.bottomAnchor.constraint(equalTo: sellView.topAnchor, constant: -15).isActive = true
        investment.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        investment.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        investment.heightAnchor.constraint(equalToConstant: 55).isActive = true

        investmentVal.translatesAutoresizingMaskIntoConstraints = false
        investmentVal.topAnchor.constraint(equalTo: investment.centerYAnchor).isActive = true
        investmentVal.leadingAnchor.constraint(equalTo: investment.leadingAnchor, constant: 30).isActive = true
        investmentVal.trailingAnchor.constraint(equalTo: investment.trailingAnchor, constant: -30).isActive = true

        investmentTitle.translatesAutoresizingMaskIntoConstraints = false
        investmentTitle.bottomAnchor.constraint(equalTo: investment.centerYAnchor, constant: -3).isActive = true
        investmentTitle.leadingAnchor.constraint(equalTo: investment.leadingAnchor, constant: 30).isActive = true
        investmentTitle.trailingAnchor.constraint(equalTo: investment.trailingAnchor, constant: -30).isActive = true

        titleBalance.translatesAutoresizingMaskIntoConstraints = false
        titleBalance.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        titleBalance.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true

        labelBalance.translatesAutoresizingMaskIntoConstraints = false
        labelBalance.topAnchor.constraint(equalTo: titleBalance.bottomAnchor, constant: 5).isActive = true
        labelBalance.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true

        imgDeposit.translatesAutoresizingMaskIntoConstraints = false
        imgDeposit.centerYAnchor.constraint(equalTo: labelBalance.centerYAnchor).isActive = true
        imgDeposit.leadingAnchor.constraint(equalTo: labelBalance.trailingAnchor, constant: 8).isActive = true
        imgDeposit.heightAnchor.constraint(equalToConstant: 20).isActive = true
        imgDeposit.widthAnchor.constraint(equalToConstant: 20).isActive = true


        assetView.translatesAutoresizingMaskIntoConstraints = false
        assetView.bottomAnchor.constraint(equalTo: investment.topAnchor, constant: -12).isActive = true
        assetView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        assetView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        assetView.heightAnchor.constraint(equalToConstant: 55).isActive = true

        pairLabel.translatesAutoresizingMaskIntoConstraints = false
        pairLabel.topAnchor.constraint(equalTo: assetView.centerYAnchor).isActive = true
        pairLabel.leadingAnchor.constraint(equalTo: assetView.leadingAnchor, constant: 20).isActive = true

        tradingAssetTitle.translatesAutoresizingMaskIntoConstraints = false
        tradingAssetTitle.bottomAnchor.constraint(equalTo: assetView.centerYAnchor, constant: -3).isActive = true
        tradingAssetTitle.leadingAnchor.constraint(equalTo: assetView.leadingAnchor, constant: 20).isActive = true

        imgArrowRight.translatesAutoresizingMaskIntoConstraints = false
        imgArrowRight.centerYAnchor.constraint(equalTo: assetView.centerYAnchor).isActive = true
        imgArrowRight.trailingAnchor.constraint(equalTo: assetView.trailingAnchor, constant: -16).isActive = true
        imgArrowRight.heightAnchor.constraint(equalToConstant: 24).isActive = true
        imgArrowRight.widthAnchor.constraint(equalToConstant: 24).isActive = true

        chart.translatesAutoresizingMaskIntoConstraints = false
        chart.topAnchor.constraint(equalTo: labelBalance.bottomAnchor, constant: 25).isActive = true
        chart.bottomAnchor.constraint(equalTo: assetView.topAnchor, constant: -30).isActive = true
        chart.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        chart.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

        chartView.translatesAutoresizingMaskIntoConstraints = false
        chartView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        chartView.bottomAnchor.constraint(equalTo: chart.bottomAnchor).isActive = true
        chartView.leadingAnchor.constraint(equalTo: chart.leadingAnchor).isActive = true
        chartView.trailingAnchor.constraint(equalTo: chart.trailingAnchor).isActive = true
    }
}

extension PlatformController: PairDelegate {
    func updatePair(_ value: String?) {
        guard let key = value else { return }

        pair = BinBotContent.shared.pairs.first(where: {$0.key == key})

        guard let pair = pair else { return }
        pairLabel.text = pair.key.prefix(3) + "/" + pair.key.suffix(3)

        let content = TradingView(width: chart.frame.width - 20.0, height: chart.frame.height, symbol: pair.0).getHTMLContent()
        chart.loadHTMLString(content, baseURL: nil)
    }
}

extension PlatformController {
    func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done".localize(), style: .done, target: self, action: #selector(self.doneButtonAction))

        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()

        labelBalance.inputAccessoryView = doneToolbar
    }

    @objc func doneButtonAction() {
        let balance = Int(labelBalance.text!)
        UserDefaults.standard.set(balance, forKey: UserData.SettingsKeys.balance.rawValue)
        self.labelBalance.text = "\(UserData.balance) Đ"
        labelBalance.resignFirstResponder()
    }

    private func taskForPair(amount: Double) {
        DispatchQueue.main.asyncAfter(deadline: .now() + DispatchTimeInterval.seconds(60)) { [self] in
            let profit = Double.random(in: 0.0..<0.075)
            let sign = Bool.random() ? 1.0 : -1.0
            var balance = UserData.balance
            balance = balance + Int(self.invValue + sign * profit * amount)
            UserDefaults.standard.set(balance, forKey: UserData.SettingsKeys.balance.rawValue)
            self.labelBalance.text = "\(UserData.balance) Đ"
        }
    }

    @objc private func sellAction() {
        showToast(message: "trade.open1".localize() + "\(1) minute. " + "trade.open2".localize() + "\(round(price * 100000) / 100000.0)")
        taskForPair(amount: Double(invValue))

        UserDefaults.standard.set((UserData.balance - Int(invValue)), forKey: UserData.SettingsKeys.balance.rawValue)
        self.labelBalance.text = "\(UserData.balance) Đ"
        if Int(invValue) > UserData.balance {
            invValue = 0
            investmentVal.text = "\(Int(invValue))"
        }
    }

    @objc private func buyAction() {
        showToast(message: "trade.open1".localize() + "\(1) minute. " + "trade.open2".localize() + "\(round(price * 100000) / 100000.0)")
        taskForPair(amount: Double(invValue))


        UserDefaults.standard.set((UserData.balance - Int(invValue)), forKey: UserData.SettingsKeys.balance.rawValue)
        self.labelBalance.text = "\(UserData.balance) Đ"
        if Int(invValue) > UserData.balance {
            invValue = 0
            investmentVal.text = "\(Int(invValue))"
        }
    }

    @objc private func tapDeposit() {
        let vc = DepositController()
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc private func tapPair() {
        let vc = PairViewController()
        vc.pair = pair?.key
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc private func tapPlusMinus(_ sender: UIButton) {
        switch sender {
        case plusInv: invValue += 100
            investmentVal.text = "\(Int(invValue))"
        case minusInv: invValue -= 100
            if invValue < 0 {
                invValue = Double(Int(0))
            }
            investmentVal.text = "\(Int(invValue))"
        default: break
        }
    }
}
