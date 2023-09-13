import UIKit

protocol QuizDelegate: AnyObject {
    func updateQuiz(day: Int)
}

final class SupportController: UIViewController {
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.text = "Quiz".localize()
        view.font = .systemFont(ofSize: 18, weight: .bold)
        view.textAlignment = .center
        return view
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
        let view = UILabel()
        view.textColor = UIColor(red: 0.584, green: 0.612, blue: 0.663, alpha: 1)
        view.text = "description.question".localize()
        view.font = .systemFont(ofSize: 16, weight: .regular)
        view.textAlignment = .center
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        return view
    }()

    private let welcomeLabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.text = "Welcome".localize()
        view.font = .systemFont(ofSize: 20, weight: .bold)
        view.textAlignment = .center
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        return view
    }()

    private let viewTime: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.26, green: 0.276, blue: 0.33, alpha: 1)
        view.layer.cornerRadius = 10
        return view
    }()

    private let allowLabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.text = "allow".localize()
        view.font = .systemFont(ofSize: 16, weight: .regular)
        view.textAlignment = .center
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        return view
    }()

    private let timeLabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.font = .systemFont(ofSize: 32, weight: .bold)
        view.textAlignment = .center
        return view
    }()

    private let passedLabel: UILabel = {
        let view = UILabel()
        view.textColor = UIColor(red: 1, green: 0.855, blue: 0.267, alpha: 1)
        view.text = "passed".localize()
        view.font = .systemFont(ofSize: 20, weight: .bold)
        view.textAlignment = .center
        return view
    }()

    private let numberLabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.text = "correctAns".localize()
        view.font = .systemFont(ofSize: 16, weight: .regular)
        view.textAlignment = .center
        return view
    }()

    private let numberAllLabel: UILabel = {
        let view = UILabel()
        view.textColor = UIColor(red: 0.584, green: 0.612, blue: 0.663, alpha: 1)
        view.text = " / 5"
        view.font = .systemFont(ofSize: 20, weight: .bold)
        view.textAlignment = .left
        return view
    }()

    private let numberTrueLabel: UILabel = {
        let view = UILabel()
        view.textColor = UIColor(red: 1, green: 0.855, blue: 0.267, alpha: 1)
        view.font = .systemFont(ofSize: 20, weight: .bold)
        view.textAlignment = .right
        return view
    }()

    private let img: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "imgForQuiz")
        view.contentMode = .scaleAspectFit
        return view
    }()

    weak var delegateQuiz: QuizDelegate?
    private var day: Int?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let date1 = Date()
        var date2 = UserData.dateStartQuiz ?? Date()
        date2 += (60 * 60 * 24)

        let newTime = secondsToHoursMinutesSeconds(seconds: Int( date1.timeIntervalSince(date2)))

        if (newTime.0 <= 0 || newTime.0 == 24) && newTime.1 <= 0 && newTime.2 <= 0 {
            UserDefaults.standard.set(false, forKey: UserData.SettingsKeys.isWorkQuiz.rawValue)
        } else {
            UserDefaults.standard.set(true, forKey: UserData.SettingsKeys.isWorkQuiz.rawValue)
        }

        if !UserData.isWorkQuiz {
            numberTrueLabel.text = "\(UserDefaults.standard.integer(forKey: "correct"))"
            timeLabel.text = "\(lengthStr(time: newTime.0)):\(lengthStr(time: newTime.1)):\(lengthStr(time: newTime.2))"
            noIsFirstHidden()

            btnContinue.isUserInteractionEnabled = false
            btnContinue.setTitle("share".localize(), for: .normal)

            if UserData.isFirst {
                UserDefaults.standard.set(0, forKey: UserData.SettingsKeys.dayQuiz.rawValue)
                day = UserData.dayQuiz
                isFirstHidden()

                btnContinue.isUserInteractionEnabled = true
                btnContinue.setTitle("Continue".localize(), for: .normal)
            }
        } else {
            let newDay = UserData.dayQuiz
            UserDefaults.standard.set((newDay + 1), forKey: "dayQuiz")
            if (UserData.dayQuiz + 1) < 7 {
                day = UserData.dayQuiz
                isFirstHidden()

                btnContinue.isUserInteractionEnabled = true
                btnContinue.setTitle("Continue".localize(), for: .normal)
            } else {
                isFirstHidden()
                btnContinue.isUserInteractionEnabled = false
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = UIColor(red: 0.165, green: 0.169, blue: 0.188, alpha: 1)

        setupUI()
    }
}

private extension SupportController {
    func setupUI() {
        view.addSubviews(titleLabel, btnContinue, descriptionLabel, welcomeLabel, viewTime, passedLabel, numberLabel, numberAllLabel, numberTrueLabel, img)
        viewTime.addSubviews(allowLabel, timeLabel)

        img.snp.makeConstraints { make in
            make.bottom.equalTo(viewTime.snp.bottom).offset(-16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.width.equalTo(270)
        }

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

        btnContinue.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}

private extension SupportController {
    @objc func tapButtonNext() {
        let vc = QuizController()
        navigationController?.pushViewController(vc, animated: false)
        delegateQuiz = vc
        delegateQuiz?.updateQuiz(day: day ?? 0)
    }
}

private extension SupportController {
    func lengthStr(time: Int) -> String {
        var str = ""
        if time < 0 {
            str = String(time).count == 2 ? "0\(abs(time))" :  "\(abs(time))"
        } else {
            str = String(time).count == 1 ? "0\(abs(time))" :  "\(abs(time))"
        }
        return str
    }

    func isFirstHidden() {
        welcomeLabel.isHidden = false
        descriptionLabel.isHidden = false
        numberTrueLabel.isHidden = true
        numberLabel.isHidden = true
        numberAllLabel.isHidden = true
        passedLabel.isHidden = true
        viewTime.isHidden = true
        img.isHidden = false
    }

    func noIsFirstHidden() {
        welcomeLabel.isHidden = true
        descriptionLabel.isHidden = true
        numberTrueLabel.isHidden = false
        numberLabel.isHidden = false
        numberAllLabel.isHidden = false
        passedLabel.isHidden = false
        viewTime.isHidden = false
        img.isHidden = true
    }

    func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
}
