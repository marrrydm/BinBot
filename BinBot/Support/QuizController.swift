import UIKit

protocol ResultDelegate: AnyObject {
    func updateQuiz(result: Int, title: String?, num: Int, numSection: Int)
}

final class QuizController: UIViewController {
    private let labelTitle: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.text = "Quiz".localize()
        view.font = .systemFont(ofSize: 18, weight: .bold)
        view.textAlignment = .center
        return view
    }()

    private lazy var imgView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()

    private let questionLbl: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.font = .systemFont(ofSize: 20, weight: .bold)
        view.textAlignment = .center
        view.lineBreakMode = .byWordWrapping
        view.numberOfLines = 0
        return view
    }()

    private lazy var viewYes: UIButton = {
        let view = UIButton()
        view.backgroundColor = UIColor(red: 0.26, green: 0.276, blue: 0.33, alpha: 1)
        view.layer.cornerRadius = 6
        view.layer.borderWidth = 0
        view.layer.borderColor = UIColor(red: 1, green: 0.855, blue: 0.267, alpha: 1).cgColor
        view.addTarget(self, action: #selector(btnClickCheck), for: .touchUpInside)
        view.tag = 0
        return view
    }()

    private lazy var viewNo: UIButton = {
        let view = UIButton()
        view.backgroundColor = UIColor(red: 0.26, green: 0.276, blue: 0.33, alpha: 1)
        view.layer.cornerRadius = 6
        view.layer.borderWidth = 0
        view.layer.borderColor = UIColor(red: 1, green: 0.855, blue: 0.267, alpha: 1).cgColor
        view.addTarget(self, action: #selector(btnClickCheck), for: .touchUpInside)
        view.tag = 1
        return view
    }()

    private let answerLblYes: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.text = "Yes".localize()
        view.font = .systemFont(ofSize: 17, weight: .bold)
        view.textAlignment = .center
        return view
    }()

    private let answerLblNo: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.text = "No".localize()
        view.font = .systemFont(ofSize: 17, weight: .bold)
        view.textAlignment = .center
        return view
    }()

    private lazy var nextButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = UIColor(red: 1, green: 0.855, blue: 0.267, alpha: 1)
        view.layer.cornerRadius = 6
        view.setTitleColor(UIColor(red: 0.165, green: 0.169, blue: 0.188, alpha: 1), for: .normal)
        view.setTitle("Continue".localize(), for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        view.alpha = 0.5
        view.addTarget(self, action: #selector(tapButtonNext), for: .touchUpInside)
        return view
    }()

    private let correctLbl: UILabel = {
        let view = UILabel()
        view.textColor = UIColor(red: 0.584, green: 0.612, blue: 0.663, alpha: 1)
        view.font = .systemFont(ofSize: 16, weight: .regular)
        view.textAlignment = .right
        return view
    }()

    private lazy var correctImg: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()

    private let lessonsArray = StaticContent.shared.lessonsArray
    private var isStep = 0
    private var number = -1
    private var result = 0
    private var setTitle = false

    weak var delegate: ResultDelegate?

    private var isChecked: Bool = false {
        didSet {
            if viewYes.layer.borderWidth != 0 || viewNo.layer.borderWidth != 0 {
                nextButton.alpha = 1
            } else {
                nextButton.alpha = 0.5
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = UIColor(red: 0.165, green: 0.169, blue: 0.188, alpha: 1)

        setupView()
    }
}

private extension QuizController {
    func setupView() {
        view.addSubviews(labelTitle, imgView, nextButton, questionLbl, viewYes, viewNo, correctLbl, correctImg)
        viewYes.addSubview(answerLblYes)
        viewNo.addSubview(answerLblNo)

        correctImg.snp.makeConstraints({ make in
            make.bottom.equalTo(viewYes.snp.top).offset(-28)
            make.trailing.equalTo(view.snp.centerX).offset(-30)
            make.height.width.equalTo(20)
        })

        correctLbl.snp.makeConstraints({ make in
            make.centerY.equalTo(correctImg.snp.centerY)
            make.leading.equalTo(correctImg.snp.trailing).offset(3)
        })

        labelTitle.snp.makeConstraints({ make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.leading.trailing.equalToSuperview().inset(40)
        })

        imgView.snp.makeConstraints({ make in
            make.top.equalTo(labelTitle.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(208)
        })

        nextButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(50)
        }

        questionLbl.snp.makeConstraints { make in
            make.top.equalTo(imgView.snp.bottom).offset(23)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
        }

        viewYes.snp.makeConstraints { make in
            make.bottom.equalTo(nextButton.snp.top).offset(-20)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalTo(view.snp.centerX).offset(-5)
        }

        viewNo.snp.makeConstraints { make in
            make.bottom.equalTo(nextButton.snp.top).offset(-20)
            make.trailing.equalToSuperview().offset(-16)
            make.leading.equalTo(view.snp.centerX).offset(5)
        }

        answerLblYes.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.edges.equalToSuperview().inset(16)
        }

        answerLblNo.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.edges.equalToSuperview().inset(16)
        }
    }
}

private extension QuizController {
    @objc func pop() {
        navigationController?.popViewController(animated: false)
    }

    @objc func tapButtonNext() {
        if viewYes.layer.borderWidth != 0 || viewNo.layer.borderWidth != 0 {
            if isStep != 5 && nextButton.alpha == 1  {
                if !setTitle {
                    if isChecked == lessonsArray[number][isStep].1   {
                        result += 1
                        correctLbl.text = "Correct".localize()
                        correctImg.image = UIImage(named: "correct")
                        nextButton.setTitle("Got it".localize(), for: .normal)
                        viewYes.isUserInteractionEnabled = false
                        viewNo.isUserInteractionEnabled = false
                        setTitle = true
                        return
                    } else {
                        correctLbl.text = "Incorrect".localize()
                        correctImg.image = UIImage(named: "incorrect")
                        nextButton.setTitle("Got it".localize(), for: .normal)
                        viewYes.isUserInteractionEnabled = false
                        viewNo.isUserInteractionEnabled = false
                        setTitle = true
                        return
                    }
                } else {
                    isStep += 1
                    if isStep != 5 {
                        questionLbl.text = lessonsArray[number][isStep].0
                        imgView.image = lessonsArray[number][isStep].2

                        viewYes.layer.borderWidth = 0
                        viewNo.layer.borderWidth = 0

                        nextButton.alpha = 0.5
                        nextButton.setTitle("Continue".localize(), for: .normal)

                        correctLbl.text = ""
                        correctImg.image = UIImage()

                        setTitle = false

                        viewYes.isUserInteractionEnabled = true
                        viewNo.isUserInteractionEnabled = true
                    } else {
                        pop()
                        if UserDefaults.standard.integer(forKey: "correct") == 0 {
                            UserDefaults.standard.set(result, forKey: "correct")
                        }

                        let date = Date()
                        if UserData.dateStartQuiz == nil {
                            UserDefaults.standard.set(date, forKey: UserData.SettingsKeys.dateStartQuiz.rawValue)
                        }

                        UserDefaults.standard.set(date, forKey: UserData.SettingsKeys.dateStartQuiz.rawValue)

                        UserDefaults.standard.set(false, forKey: UserData.SettingsKeys.isWorkQuiz.rawValue)

                        UserDefaults.standard.set(false, forKey: UserData.SettingsKeys.isFirst.rawValue)
                    }
                }
            }
        }
    }

    @objc func btnClickCheck(_ sender: UIButton) {
        switch (sender) {
        case viewYes:
            viewYes.layer.borderWidth = 1
            viewNo.layer.borderWidth = 0
            isChecked = true
        case viewNo:
            viewNo.layer.borderWidth = 1
            viewYes.layer.borderWidth = 0
            isChecked = false
        default: break
        }
    }
}

extension QuizController: QuizDelegate {
    func updateQuiz(day: Int) {
        number = day
        questionLbl.text = lessonsArray[day][isStep].0
        imgView.image = lessonsArray[day][isStep].2
    }
}
