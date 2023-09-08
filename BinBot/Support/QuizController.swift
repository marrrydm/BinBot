import UIKit

protocol ResultDelegate: AnyObject {
    func updateQuiz(result: Int, title: String?, num: Int, numSection: Int)
}

class QuizController: UIViewController {
    private let labelTitle: UILabel = {
        let labelTitle = UILabel()
        labelTitle.textColor = .white
        labelTitle.text = "Quiz".localize()
        labelTitle.font = .systemFont(ofSize: 18, weight: .bold)
        labelTitle.textAlignment = .center

        return labelTitle
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
        let labelTitle = UILabel()
        labelTitle.textColor = UIColor(red: 0.584, green: 0.612, blue: 0.663, alpha: 1)
        labelTitle.font = .systemFont(ofSize: 16, weight: .regular)
        labelTitle.textAlignment = .right

        return labelTitle
    }()

    private lazy var correctImg: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()

    private var numberSection = 0

    private var lessonsArray: [[(String, Bool, UIImage?)]] =
    [
        [ ("quetion1.1".localize(), true, UIImage(named: "1.1")), ("quetion1.2".localize(), false, UIImage(named: "1.2")), ("quetion1.3".localize(), true, UIImage(named: "1.3")), ("quetion1.4".localize(), false, UIImage(named: "1.4")),
          ("quetion1.5".localize(), true, UIImage(named: "1.5"))],
        [ ("quetion2.1".localize(), false, UIImage(named: "2.1")), ("quetion2.2".localize(), true, UIImage(named: "2.2")), ("quetion2.3".localize(), false, UIImage(named: "2.3")), ("quetion2.4".localize(), true, UIImage(named: "2.4")),
          ("quetion2.5".localize(), false, UIImage(named: "2.5"))],
        [ ("quetion3.1".localize(), true, UIImage(named: "3.1")), ("quetion3.2".localize(), false, UIImage(named: "3.2")), ("quetion3.3".localize(), true, UIImage(named: "3.3")), ("quetion3.4".localize(), false, UIImage(named: "3.4")),
          ("quetion3.5".localize(), true, UIImage(named: "3.5"))],
        [ ("quetion4.1".localize(), false, UIImage(named: "4.1")), ("quetion4.2".localize(), true, UIImage(named: "4.2")), ("quetion4.3".localize(), false, UIImage(named: "4.3")), ("quetion4.4".localize(), true, UIImage(named: "4.4")),
          ("quetion4.5".localize(), false, UIImage(named: "4.5"))],
        [ ("quetion5.1".localize(), true, UIImage(named: "5.1")), ("quetion5.2".localize(), false, UIImage(named: "5.2")), ("quetion5.3".localize(), true, UIImage(named: "5.3")), ("quetion5.4".localize(), false, UIImage(named: "5.4")),
          ("quetion5.5".localize(), true, UIImage(named: "5.5"))],
        [ ("quetion6.1".localize(), false, UIImage(named: "6.1")), ("quetion6.2".localize(), true, UIImage(named: "6.2")), ("quetion6.3".localize(), false, UIImage(named: "6.3")), ("quetion6.4".localize(), true, UIImage(named: "6.4")),
          ("quetion6.5".localize(), false, UIImage(named: "6.5"))],
        [ ("quetion7.1".localize(), true, UIImage(named: "7.1")), ("quetion7.2".localize(), false, UIImage(named: "7.2")), ("quetion7.3".localize(), true, UIImage(named: "7.3")), ("quetion7.4".localize(), false, UIImage(named: "7.4")),
          ("quetion7.5".localize(), true, UIImage(named: "7.5"))]
    ]

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
        view.backgroundColor = UIColor(red: 0.165, green: 0.169, blue: 0.188, alpha: 1)
        navigationController?.navigationBar.isHidden = true

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

extension QuizController {
    @objc private func tapButtonNext() {
        if viewYes.layer.borderWidth != 0 || viewNo.layer.borderWidth != 0 {
            if isStep != 4 && nextButton.alpha == 1 && setTitle {
                isStep += 1
                questionLbl.text = lessonsArray[number][isStep].0
                imgView.image = lessonsArray[number][isStep].2

                viewYes.layer.borderWidth = 0
                viewNo.layer.borderWidth = 0

                nextButton.alpha = 0.5
                nextButton.setTitle("Continue".localize(), for: .normal)

                correctLbl.text = ""
                correctImg.image = UIImage()

                setTitle = false
            }

            if !setTitle {
                if isChecked == lessonsArray[number][isStep].1 {
                    result += 1
                    correctLbl.text = "Correct".localize()
                    correctImg.image = UIImage(named: "correct")
                    nextButton.setTitle("Got it".localize(), for: .normal)
                    setTitle = true
                } else {
                    correctLbl.text = "Incorrect".localize()
                    correctImg.image = UIImage(named: "incorrect")
                    nextButton.setTitle("Got it".localize(), for: .normal)
                    setTitle = true
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

extension QuizController {
    @objc private func pop() {
        navigationController?.popViewController(animated: false)
    }
}
