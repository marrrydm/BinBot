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

    weak var delegateQuiz: QuizDelegate?
    private var day: Int?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        day = 0
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.165, green: 0.169, blue: 0.188, alpha: 1)
        navigationController?.navigationBar.isHidden = true

        view.addSubviews(titleLabel, btnContinue, descriptionLabel, welcomeLabel, viewTime)
        viewTime.addSubviews(allowLabel, timeLabel)

        allowLabel.snp.makeConstraints { make in
            make.bottom.equalTo(timeLabel.snp.top).offset(-8)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        timeLabel.snp.makeConstraints { make in
            make.bottom.equalTo(viewTime.snp.bottom).offset(-16)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        viewTime.snp.makeConstraints { make in
            make.bottom.equalTo(welcomeLabel.snp.top).offset(-50)
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
    @objc private func tapButtonNext() {
        let vc = QuizController()
        navigationController?.pushViewController(vc, animated: false)
        delegateQuiz = vc
        delegateQuiz?.updateQuiz(day: day ?? 0)
    }
}
