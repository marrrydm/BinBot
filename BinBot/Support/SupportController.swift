import UIKit

protocol QuizDelegate: AnyObject {
    func updateQuiz(day: Int)
}

class SupportController: UIViewController {
    private let titleLabel: UILabel = {
        let labelTitle = UILabel()
        labelTitle.textColor = .white
        labelTitle.text = "Quiz".localize()
        labelTitle.font = .systemFont(ofSize: 18, weight: .bold)
        labelTitle.textAlignment = .center

        return labelTitle
    }()

    private lazy var btnContinue: UIButton = {
        let view = UIButton()
        view.backgroundColor = UIColor(red: 1, green: 0.855, blue: 0.267, alpha: 1)
        view.layer.cornerRadius = 6
        view.setTitleColor(UIColor(red: 0.165, green: 0.169, blue: 0.188, alpha: 1), for: .normal)
        view.setTitle("Continue".localize(), for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        view.addTarget(self, action: #selector(tapButtonNext), for: .touchUpInside)

        return view
    }()

    private let descriptionLabel: UILabel = {
        let labelTitle = UILabel()
        labelTitle.textColor = UIColor(red: 0.584, green: 0.612, blue: 0.663, alpha: 1)
        labelTitle.text = "description.question".localize()
        labelTitle.font = .systemFont(ofSize: 16, weight: .regular)
        labelTitle.textAlignment = .center
        labelTitle.numberOfLines = 0
        labelTitle.lineBreakMode = .byWordWrapping

        return labelTitle
    }()

    private let welcomeLabel: UILabel = {
        let labelTitle = UILabel()
        labelTitle.textColor = .white
        labelTitle.text = "Welcome".localize()
        labelTitle.font = .systemFont(ofSize: 20, weight: .bold)
        labelTitle.textAlignment = .center
        labelTitle.numberOfLines = 0
        labelTitle.lineBreakMode = .byWordWrapping

        return labelTitle
    }()

    private let viewTime: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.26, green: 0.276, blue: 0.33, alpha: 1)
        view.layer.cornerRadius = 10
        return view
    }()

    private let allowLabel: UILabel = {
        let labelTitle = UILabel()
        labelTitle.textColor = .white
        labelTitle.text = "allow".localize()
        labelTitle.font = .systemFont(ofSize: 16, weight: .regular)
        labelTitle.textAlignment = .center
        labelTitle.numberOfLines = 0
        labelTitle.lineBreakMode = .byWordWrapping

        return labelTitle
    }()

    private let timeLabel: UILabel = {
        let labelTitle = UILabel()
        labelTitle.textColor = .white
        labelTitle.text = "23:21:48"
        labelTitle.font = .systemFont(ofSize: 32, weight: .bold)
        labelTitle.textAlignment = .center

        return labelTitle
    }()

    private let passedLabel: UILabel = {
        let labelTitle = UILabel()
        labelTitle.textColor = UIColor(red: 1, green: 0.855, blue: 0.267, alpha: 1)
        labelTitle.text = "passed".localize()
        labelTitle.font = .systemFont(ofSize: 20, weight: .bold)
        labelTitle.textAlignment = .center

        return labelTitle
    }()

    private let numberLabel: UILabel = {
        let labelTitle = UILabel()
        labelTitle.textColor = .white
        labelTitle.text = "correctAns".localize()
        labelTitle.font = .systemFont(ofSize: 16, weight: .regular)
        labelTitle.textAlignment = .center

        return labelTitle
    }()

    private let numberAllLabel: UILabel = {
        let labelTitle = UILabel()
        labelTitle.textColor = UIColor(red: 0.584, green: 0.612, blue: 0.663, alpha: 1)
        labelTitle.text = " / 5"
        labelTitle.font = .systemFont(ofSize: 20, weight: .bold)
        labelTitle.textAlignment = .left

        return labelTitle
    }()

    private let numberTrueLabel: UILabel = {
        let labelTitle = UILabel()
        labelTitle.textColor = UIColor(red: 1, green: 0.855, blue: 0.267, alpha: 1)
        labelTitle.font = .systemFont(ofSize: 20, weight: .bold)
        labelTitle.textAlignment = .right

        return labelTitle
    }()

    weak var delegateQuiz: QuizDelegate?
    private var day: Int?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let date1 = Date()
        var date2 = UserData.dateStartQuiz ?? Date()
        date2 += (60 * 60 * 24)
        let newTime = secondsToHoursMinutesSeconds(seconds: Int(date1.timeIntervalSince(date2)))
        
        if newTime.0 <= 0 && newTime.1 <= 0 && newTime.2 <= 0 {
            UserDefaults.standard.set(false, forKey: UserData.SettingsKeys.isWorkQuiz.rawValue)
        } else {
            UserDefaults.standard.set(true, forKey: UserData.SettingsKeys.isWorkQuiz.rawValue)
        }

        var newTimeStr1 = "\(abs(newTime.0))"
        var newTimeStr2 = "\(abs(newTime.1))"
        var newTimeStr3 = "\(abs(newTime.2))"

        if String(newTime.0).count == 2 || String(newTime.0).count == 1 {
            newTimeStr1 = "0\(abs(newTime.0))"
        }

        if String(newTime.1).count == 2 || String(newTime.1).count == 1 {
            newTimeStr2 = "0\(abs(newTime.1))"
        }

        if String(newTime.2).count == 2 || String(newTime.2).count == 1 {
            newTimeStr3 = "0\(abs(newTime.2))"
        }

        if !UserData.isWorkQuiz {
            numberTrueLabel.text = "\(UserDefaults.standard.integer(forKey: "correct"))"
            timeLabel.text = "\(newTimeStr1):\(newTimeStr2):\(newTimeStr3)"
            welcomeLabel.isHidden = true
            descriptionLabel.isHidden = true
            numberTrueLabel.isHidden = false
            numberLabel.isHidden = false
            numberAllLabel.isHidden = false
            passedLabel.isHidden = false

            btnContinue.isUserInteractionEnabled = false
            btnContinue.setTitle("share".localize(), for: .normal)
        } else {
            let newDay = UserData.dayQuiz
            UserDefaults.standard.set((newDay + 1), forKey: "dayQuiz")
            day = UserData.dayQuiz
            timeLabel.text = "\(newTimeStr1):\(newTimeStr2):\(newTimeStr3)"
            welcomeLabel.isHidden = false
            descriptionLabel.isHidden = false
            numberTrueLabel.isHidden = true
            numberLabel.isHidden = true
            numberAllLabel.isHidden = true
            passedLabel.isHidden = true

            btnContinue.isUserInteractionEnabled = true
            btnContinue.setTitle("Continue".localize(), for: .normal)
        }

        if UserData.isFirst {
            UserDefaults.standard.set(0, forKey: UserData.SettingsKeys.dayQuiz.rawValue)
            day = UserData.dayQuiz
            timeLabel.text = "\(newTimeStr1):\(newTimeStr2):\(newTimeStr3)"
            welcomeLabel.isHidden = false
            descriptionLabel.isHidden = false
            numberTrueLabel.isHidden = true
            numberLabel.isHidden = true
            numberAllLabel.isHidden = true
            passedLabel.isHidden = true

            btnContinue.isUserInteractionEnabled = true
            btnContinue.setTitle("Continue".localize(), for: .normal)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.165, green: 0.169, blue: 0.188, alpha: 1)
        navigationController?.navigationBar.isHidden = true

        view.addSubviews(titleLabel, btnContinue, descriptionLabel, welcomeLabel, viewTime, passedLabel, numberLabel, numberAllLabel, numberTrueLabel)
        viewTime.addSubviews(allowLabel, timeLabel)

        numberAllLabel.snp.makeConstraints { make in
            make.top.equalTo(numberLabel.snp.bottom).offset(4)
            make.leading.equalTo(numberTrueLabel.snp.trailing).offset(2)
        }

        numberTrueLabel.snp.makeConstraints { make in
            make.top.equalTo(numberLabel.snp.bottom).offset(4)
            make.trailing.equalTo(view.snp.centerX).offset(-2)
        }

        numberLabel.snp.makeConstraints { make in
            make.top.equalTo(viewTime.snp.bottom).offset(13)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        passedLabel.snp.makeConstraints { make in
            make.bottom.equalTo(viewTime.snp.top).offset(-25)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        allowLabel.snp.makeConstraints { make in
            make.bottom.equalTo(timeLabel.snp.top).offset(-8)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        timeLabel.snp.makeConstraints { make in
            make.bottom.equalTo(viewTime.snp.bottom).offset(-16)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        viewTime.snp.makeConstraints { make in
            make.bottom.equalTo(welcomeLabel.snp.top).offset(-80)
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(allowLabel.snp.top).offset(-16)
        }

        welcomeLabel.snp.makeConstraints { make in
            make.bottom.equalTo(descriptionLabel.snp.top).offset(-5)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.bottom.equalTo(btnContinue.snp.top).offset(-50)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        btnContinue.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
    }
}

extension SupportController {
    private func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }

    @objc private func tapButtonNext() {
        let vc = QuizController()
        navigationController?.pushViewController(vc, animated: false)
        delegateQuiz = vc
        delegateQuiz?.updateQuiz(day: day ?? 0)
    }
}
