import UIKit

class Onboarding1: UIViewController {
    private let labelTitle: UILabel = {
        let view = UILabel()
        view.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        view.font = .systemFont(ofSize: 20, weight: .bold)
        view.numberOfLines = 0
        view.textAlignment = .center
        view.lineBreakMode = .byWordWrapping
        return view
    }()

    private let contentLabel: UILabel = {
        let view = UILabel()
        view.textColor = UIColor(red: 0.584, green: 0.612, blue: 0.663, alpha: 1)
        view.font = .systemFont(ofSize: 16, weight: .regular)
        view.numberOfLines = 0
        view.textAlignment = .center
        view.lineBreakMode = .byWordWrapping
        return view
    }()

    private let imgView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "onb1")
        view.contentMode = .scaleAspectFit
        return view
    }()

    private let imgView2: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "onb2")
        view.contentMode = .scaleAspectFit
        return view
    }()

    private let imgView3: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "onb3")
        view.contentMode = .scaleAspectFit
        return view
    }()

    private let imgView4: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "onb4")
        view.contentMode = .scaleAspectFit
        return view
    }()

    private let imgView5: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "onb5")
        view.contentMode = .scaleAspectFit
        return view
    }()

    private let imgView6: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "onb6")
        view.contentMode = .scaleAspectFit
        return view
    }()

    private let imgControl: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()

    private lazy var nextButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = UIColor(red: 1, green: 0.855, blue: 0.267, alpha: 1)
        view.layer.cornerRadius = 6
        view.setTitleColor(UIColor(red: 0.165, green: 0.169, blue: 0.188, alpha: 1), for: .normal)
        view.setTitle("next".localize(), for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        view.addTarget(self, action: #selector(tapButtonNext), for: .touchUpInside)
        return view
    }()

    private let arrayData = StaticContent.shared.arrayData
    private var count = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.165, green: 0.169, blue: 0.188, alpha: 1)

        setupUI()

        labelTitle.text = arrayData[count].title
        contentLabel.text = arrayData[count].description
        imgControl.image = arrayData[count].imgProgress

        UserDefaults.standard.setValue(true, forKey: "showOnb")
    }
}

private extension Onboarding1 {
    private func setupUI() {
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

private extension Onboarding1 {
    @objc func tapButtonNext(sender: UITapGestureRecognizer) {
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
                imgView6.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
                imgView6.heightAnchor.constraint(equalToConstant: 180).isActive = true
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
