import UIKit

class Onboarding1: UIViewController {
    private let labelTitle = UILabel()
    private let contentLabel = UILabel()
    private var imgView = UIImageView(image: UIImage(named: "onb1"))
    private var imgView2 = UIImageView(image: UIImage(named: "onb2"))
    private var imgView3 = UIImageView(image: UIImage(named: "onb3"))
    private var imgView4 = UIImageView(image: UIImage(named: "onb4"))
    private var imgView5 = UIImageView(image: UIImage(named: "onb5"))
    private var imgView6 = UIImageView(image: UIImage(named: "onb6"))
    private let imgControl = UIImageView(image: UIImage(named: "control1"))
    private let nextButton = UIButton()
    private var count = 0
    private let arrayData = [
        OnboardingModel(title: "onb1.title".localize(), description: "onb1.content".localize(), imgProgress: UIImage(named: "control1")!, img: UIImage(named: "onb1")),
        OnboardingModel(title: "onb2.title".localize(), description: "onb2.content".localize(), imgProgress: UIImage(named: "control2")!, img: UIImage(named: "onb2")),
        OnboardingModel(title: "onb3.title".localize(), description: "onb3.content".localize(), imgProgress: UIImage(named: "control3")!, img: UIImage(named: "onb3")),
        OnboardingModel(title: "onb4.title".localize(), description: "onb4.content".localize(), imgProgress: UIImage(named: "control4")!, img: UIImage(named: "onb4")),
        OnboardingModel(title: "onb5.title".localize(), description: "onb5.content".localize(), imgProgress: UIImage(named: "control5")!, img: UIImage(named: "onb5")),
        OnboardingModel(title: "onb6.title".localize(), description: "onb6.content".localize(), imgProgress: UIImage(named: "control6")!, img: UIImage(named: "onb6"))
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.165, green: 0.169, blue: 0.188, alpha: 1)
        firstSetup()

        UserDefaults.standard.setValue(true, forKey: "showOnb")
    }

    private func firstSetup() {
        view.addSubview(nextButton)
        view.addSubview(imgView)
        view.addSubview(labelTitle)
        view.addSubview(contentLabel)
        view.addSubview(imgControl)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        imgView.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        imgControl.translatesAutoresizingMaskIntoConstraints = false

        nextButton.backgroundColor = UIColor(red: 1, green: 0.855, blue: 0.267, alpha: 1)
        nextButton.layer.cornerRadius = 6
        nextButton.setTitleColor(UIColor(red: 0.165, green: 0.169, blue: 0.188, alpha: 1), for: .normal)
        nextButton.setTitle("next".localize(), for: .normal)
        nextButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        nextButton.addTarget(self, action: #selector(tapButtonNext), for: .touchUpInside)

        imgView.contentMode = .scaleAspectFit

        labelTitle.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        labelTitle.text = arrayData[count].title
        labelTitle.font = .systemFont(ofSize: 20, weight: .bold)
        labelTitle.numberOfLines = 0
        labelTitle.textAlignment = .center
        labelTitle.lineBreakMode = .byWordWrapping

        contentLabel.text = arrayData[count].description
        contentLabel.textColor = UIColor(red: 0.584, green: 0.612, blue: 0.663, alpha: 1)
        contentLabel.font = .systemFont(ofSize: 16, weight: .regular)
        contentLabel.numberOfLines = 0
        contentLabel.textAlignment = .center
        contentLabel.lineBreakMode = .byWordWrapping

        imgControl.image = arrayData[count].imgProgress
        imgControl.contentMode = .scaleAspectFit

        nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        imgView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imgView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: 200).isActive = true

        contentLabel.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -45).isActive = true
        contentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        contentLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true

        labelTitle.bottomAnchor.constraint(equalTo: contentLabel.topAnchor, constant: -2).isActive = true
        labelTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        labelTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true

        imgControl.topAnchor.constraint(equalTo: imgView.bottomAnchor, constant: 50).isActive = true
        imgControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imgControl.heightAnchor.constraint(equalToConstant: 8).isActive = true
        imgControl.widthAnchor.constraint(equalToConstant: 76).isActive = true
    }
}

extension Onboarding1 {
    @objc private func tapButtonNext(sender: UITapGestureRecognizer) {
        count += 1
        if count < 6 {
            labelTitle.text = arrayData[count].title
            contentLabel.text = arrayData[count].description
            imgControl.image = arrayData[count].imgProgress
            switch count {
            case 1:
                view.addSubview(imgView2)
                imgView2.contentMode = .scaleAspectFit
                imgView2.translatesAutoresizingMaskIntoConstraints = false
                imgView2.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20).isActive = true
                imgView2.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
                imgView2.heightAnchor.constraint(equalToConstant: 200).isActive = true
                imgView.isHidden = true
            case 2:
                view.addSubview(imgView3)
                imgView3.contentMode = .scaleAspectFit
                imgView3.translatesAutoresizingMaskIntoConstraints = false
                imgView3.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20).isActive = true
                imgView3.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
                imgView3.heightAnchor.constraint(equalToConstant: 200).isActive = true
                imgView2.isHidden = true
            case 3:
                view.addSubview(imgView4)
                imgView4.contentMode = .scaleAspectFit
                imgView4.translatesAutoresizingMaskIntoConstraints = false
                imgView4.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20).isActive = true
                imgView4.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
                imgView4.heightAnchor.constraint(equalToConstant: 200).isActive = true
                imgView3.isHidden = true
            case 4:
                view.addSubview(imgView5)
                imgView5.contentMode = .scaleAspectFit
                imgView5.translatesAutoresizingMaskIntoConstraints = false
                imgView5.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20).isActive = true
                imgView5.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
                imgView5.heightAnchor.constraint(equalToConstant: 200).isActive = true
                imgView4.isHidden = true
            case 5:
                view.addSubview(imgView6)
                imgView6.contentMode = .scaleAspectFit
                imgView6.translatesAutoresizingMaskIntoConstraints = false
                imgView6.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20).isActive = true
                imgView6.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -40).isActive = true
                imgView6.heightAnchor.constraint(equalToConstant: 200).isActive = true
                imgView5.isHidden = true
            default: break
            }
        } else {
            //            if UserData.showedAuth {
            let vc = TabBarController()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false)
            //            } else {
            //                let vc = StartLoginVC()
            //                vc.modalPresentationStyle = .fullScreen
            //                present(vc, animated: false)
            //            }
        }
    }
}
