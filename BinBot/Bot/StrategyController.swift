import UIKit

class StrategyController: UIViewController, UIScrollViewDelegate {
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

    private lazy var leftBarButton: UIImageView = {
        let leftBarButton = UIImageView()
        leftBarButton.image = UIImage(named: "close")
        leftBarButton.isUserInteractionEnabled = true
        leftBarButton.contentMode = .scaleAspectFit
        leftBarButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didLeftBarButtonTapped)))

        return leftBarButton
    }()

    private var imgSum: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "sum")
        view.contentMode = .scaleAspectFit
        return view
    }()

    private var picSum: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "pic1")
        view.contentMode = .scaleAspectFit
        return view
    }()

    private let titleLabelSum: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.text = "Indicators: Summary".localize()
        view.font = .systemFont(ofSize: 13, weight: .bold)
        view.textAlignment = .left
        return view
    }()

    private let contentLabel: UILabel = {
        let labelTitle = UILabel()
        labelTitle.textColor = .white
        labelTitle.text = "indicators.content".localize()
        labelTitle.font = .systemFont(ofSize: 11, weight: .regular)
        labelTitle.textAlignment = .left
        labelTitle.numberOfLines = 0
        labelTitle.lineBreakMode = .byWordWrapping

        return labelTitle
    }()

    private let bgViewSummary: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = UIColor(red: 0.259, green: 0.275, blue: 0.329, alpha: 1)
        bgView.layer.cornerRadius = 10
        return bgView
    }()

    private let bgTitle1: UILabel = {
        let labelTitle = UILabel()
        labelTitle.textColor = .white
        labelTitle.text = "Technical indicators".localize()
        labelTitle.font = .systemFont(ofSize: 14, weight: .bold)
        labelTitle.textAlignment = .left
        labelTitle.numberOfLines = 0
        labelTitle.lineBreakMode = .byWordWrapping

        return labelTitle
    }()

    private let bgContent1: UILabel = {
        let labelTitle = UILabel()
        labelTitle.textColor = UIColor(red: 0.584, green: 0.612, blue: 0.663, alpha: 1)
        labelTitle.text = "bg1.content".localize()
        labelTitle.font = .systemFont(ofSize: 11, weight: .regular)
        labelTitle.textAlignment = .left
        labelTitle.numberOfLines = 0
        labelTitle.lineBreakMode = .byWordWrapping

        return labelTitle
    }()

    private let bgTitle2: UILabel = {
        let labelTitle = UILabel()
        labelTitle.textColor = .white
        labelTitle.text = "Moving Averages".localize()
        labelTitle.font = .systemFont(ofSize: 14, weight: .bold)
        labelTitle.textAlignment = .left
        labelTitle.numberOfLines = 0
        labelTitle.lineBreakMode = .byWordWrapping

        return labelTitle
    }()

    private let bgContent2: UILabel = {
        let view = UILabel()
        view.textColor = UIColor(red: 0.584, green: 0.612, blue: 0.663, alpha: 1)
        view.text = "bg2.content".localize()
        view.font = .systemFont(ofSize: 11, weight: .regular)
        view.textAlignment = .left
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        return view
    }()

    private lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.584, green: 0.612, blue: 0.663, alpha: 1)
        return view
    }()

    private var imgMac: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "mac")
        view.contentMode = .scaleAspectFit
        return view
    }()

    private var picMac: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "pic2")
        view.contentMode = .scaleAspectFit
        return view
    }()

    private let titleLabelMac: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.text = "MACD".localize()
        view.font = .systemFont(ofSize: 13, weight: .bold)
        view.textAlignment = .left
        return view
    }()

    private let contentLabelMac: UILabel = {
        let labelTitle = UILabel()
        labelTitle.textColor = .white
        labelTitle.text = "mac.content".localize()
        labelTitle.font = .systemFont(ofSize: 11, weight: .regular)
        labelTitle.textAlignment = .left
        labelTitle.numberOfLines = 0
        labelTitle.lineBreakMode = .byWordWrapping
        return labelTitle
    }()

    private let descriptionMac: UILabel = {
        let labelTitle = UILabel()
        labelTitle.textColor = .white
        labelTitle.text = "mac.desc".localize()
        labelTitle.font = .systemFont(ofSize: 11, weight: .regular)
        labelTitle.textAlignment = .left
        labelTitle.numberOfLines = 0
        labelTitle.lineBreakMode = .byWordWrapping

        return labelTitle
    }()

    private lazy var lineView2: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.584, green: 0.612, blue: 0.663, alpha: 1)
        return view
    }()

    private var imgSto: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "sto")
        view.contentMode = .scaleAspectFit
        return view
    }()

    private var picSto: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "pic3")
        view.contentMode = .scaleAspectFit
        return view
    }()

    private let titleLabelSto: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.text = "Stochastic".localize()
        view.font = .systemFont(ofSize: 13, weight: .bold)
        view.textAlignment = .left
        return view
    }()

    private let contentLabelSto: UILabel = {
        let labelTitle = UILabel()
        labelTitle.textColor = .white
        labelTitle.text = "sto.content".localize()
        labelTitle.font = .systemFont(ofSize: 11, weight: .regular)
        labelTitle.textAlignment = .left
        labelTitle.numberOfLines = 0
        labelTitle.lineBreakMode = .byWordWrapping
        return labelTitle
    }()

    private let descriptionSto: UILabel = {
        let labelTitle = UILabel()
        labelTitle.textColor = .white
        labelTitle.text = "sto.desc".localize()
        labelTitle.font = .systemFont(ofSize: 11, weight: .regular)
        labelTitle.textAlignment = .left
        labelTitle.numberOfLines = 0
        labelTitle.lineBreakMode = .byWordWrapping

        return labelTitle
    }()

    private lazy var lineView3: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.584, green: 0.612, blue: 0.663, alpha: 1)
        return view
    }()

    private var imgBol: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "bol")
        view.contentMode = .scaleAspectFit
        return view
    }()

    private var picBol: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "pic4")
        view.contentMode = .scaleAspectFit
        return view
    }()

    private let titleLabelBol: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.text = "Bollinger Bands".localize()
        view.font = .systemFont(ofSize: 13, weight: .bold)
        view.textAlignment = .left
        return view
    }()

    private let contentLabelBol: UILabel = {
        let labelTitle = UILabel()
        labelTitle.textColor = .white
        labelTitle.text = "bol.content".localize()
        labelTitle.font = .systemFont(ofSize: 11, weight: .regular)
        labelTitle.textAlignment = .left
        labelTitle.numberOfLines = 0
        labelTitle.lineBreakMode = .byWordWrapping
        return labelTitle
    }()

    private let descriptionBol: UILabel = {
        let labelTitle = UILabel()
        labelTitle.textColor = .white
        labelTitle.text = "sto.desc".localize()
        labelTitle.font = .systemFont(ofSize: 11, weight: .regular)
        labelTitle.textAlignment = .left
        labelTitle.numberOfLines = 0
        labelTitle.lineBreakMode = .byWordWrapping

        return labelTitle
    }()

    private var lineView4: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.584, green: 0.612, blue: 0.663, alpha: 1)
        return view
    }()

    private var imgRS: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "rs")
        view.contentMode = .scaleAspectFit
        return view
    }()

    private var picRS: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "pic5")
        view.contentMode = .scaleAspectFit
        return view
    }()

    private let titleLabelRS: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.text = "RSI".localize()
        view.font = .systemFont(ofSize: 13, weight: .bold)
        view.textAlignment = .left
        return view
    }()

    private let contentLabelRS: UILabel = {
        let labelTitle = UILabel()
        labelTitle.textColor = .white
        labelTitle.text = "rs.content".localize()
        labelTitle.font = .systemFont(ofSize: 11, weight: .regular)
        labelTitle.textAlignment = .left
        labelTitle.numberOfLines = 0
        labelTitle.lineBreakMode = .byWordWrapping
        return labelTitle
    }()

    private let descriptionRS: UILabel = {
        let labelTitle = UILabel()
        labelTitle.textColor = .white
        labelTitle.text = "sto.desc".localize()
        labelTitle.font = .systemFont(ofSize: 11, weight: .regular)
        labelTitle.textAlignment = .left
        labelTitle.numberOfLines = 0
        labelTitle.lineBreakMode = .byWordWrapping

        return labelTitle
    }()

    private var lineView5: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.584, green: 0.612, blue: 0.663, alpha: 1)
        return view
    }()

    private var imgCC: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "cc")
        view.contentMode = .scaleAspectFit
        return view
    }()

    private var picCC: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "pic6")
        view.contentMode = .scaleAspectFit
        return view
    }()

    private let titleLabelCC: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.text = "CCI".localize()
        view.font = .systemFont(ofSize: 13, weight: .bold)
        view.textAlignment = .left
        return view
    }()

    private let contentLabelCC: UILabel = {
        let labelTitle = UILabel()
        labelTitle.textColor = .white
        labelTitle.text = "cc.content".localize()
        labelTitle.font = .systemFont(ofSize: 11, weight: .regular)
        labelTitle.textAlignment = .left
        labelTitle.numberOfLines = 0
        labelTitle.lineBreakMode = .byWordWrapping
        return labelTitle
    }()

    private let descriptionCC: UILabel = {
        let labelTitle = UILabel()
        labelTitle.textColor = .white
        labelTitle.text = "sto.desc".localize()
        labelTitle.font = .systemFont(ofSize: 11, weight: .regular)
        labelTitle.textAlignment = .left
        labelTitle.numberOfLines = 0
        labelTitle.lineBreakMode = .byWordWrapping

        return labelTitle
    }()

    private var lineView6: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.584, green: 0.612, blue: 0.663, alpha: 1)
        return view
    }()

    private var imgCl: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "cl")
        view.contentMode = .scaleAspectFit
        return view
    }()

    private var picCl: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "pic7")
        view.contentMode = .scaleAspectFit
        return view
    }()

    private let titleLabelCl: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.text = "Close price".localize()
        view.font = .systemFont(ofSize: 13, weight: .bold)
        view.textAlignment = .left
        return view
    }()

    private let contentLabelCl: UILabel = {
        let labelTitle = UILabel()
        labelTitle.textColor = .white
        labelTitle.text = "cl.content".localize()
        labelTitle.font = .systemFont(ofSize: 11, weight: .regular)
        labelTitle.textAlignment = .left
        labelTitle.numberOfLines = 0
        labelTitle.lineBreakMode = .byWordWrapping
        return labelTitle
    }()

    private let descriptionCl: UILabel = {
        let labelTitle = UILabel()
        labelTitle.textColor = .white
        labelTitle.text = "sto.desc".localize()
        labelTitle.font = .systemFont(ofSize: 11, weight: .regular)
        labelTitle.textAlignment = .left
        labelTitle.numberOfLines = 0
        labelTitle.lineBreakMode = .byWordWrapping

        return labelTitle
    }()

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        scrollView.layoutIfNeeded()
        scrollView.updateContentView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.165, green: 0.169, blue: 0.188, alpha: 1)
        navigationController?.navigationBar.isHidden = true
        scrollView.delegate = self

        view.addSubviews(titleLabel, scrollView, leftBarButton)
        scrollView.addSubviews(imgSum, picSum, titleLabelSum, contentLabel, bgViewSummary, lineView, imgMac, picMac, titleLabelMac, contentLabelMac, lineView2, descriptionMac, imgSto, picSto, titleLabelSto, contentLabelSto, lineView3, descriptionSto, imgBol, picBol, titleLabelBol, contentLabelBol, lineView4, descriptionBol, imgRS, picRS, titleLabelRS, contentLabelRS, lineView5, descriptionRS, imgCC, picCC, titleLabelCC, contentLabelCC, lineView6, descriptionCC, imgCl, picCl, titleLabelCl, contentLabelCl, descriptionCl)
        bgViewSummary.addSubviews(bgTitle1, bgContent1, bgTitle2, bgContent2)

        imgCl.snp.makeConstraints { make in
            make.top.equalTo(lineView6.snp.bottom).offset(32)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.height.width.equalTo(44)
        }

        titleLabelCl.snp.makeConstraints { make in
            make.bottom.equalTo(imgCl.snp.centerY).offset(-2)
            make.leading.equalTo(imgCl.snp.trailing).offset(12)
        }

        descriptionCl.snp.makeConstraints { make in
            make.top.equalTo(imgCl.snp.centerY).offset(2)
            make.leading.equalTo(imgCl.snp.trailing).offset(12)
        }

        picCl.snp.makeConstraints { make in
            make.top.equalTo(imgCl.snp.bottom).offset(11)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(178)
        }

        contentLabelCl.snp.makeConstraints { make in
            make.top.equalTo(picCl.snp.bottom).offset(13)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
        }

        imgCC.snp.makeConstraints { make in
            make.top.equalTo(lineView5.snp.bottom).offset(32)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.height.width.equalTo(44)
        }

        titleLabelCC.snp.makeConstraints { make in
            make.bottom.equalTo(imgCC.snp.centerY).offset(-2)
            make.leading.equalTo(imgCC.snp.trailing).offset(12)
        }

        descriptionCC.snp.makeConstraints { make in
            make.top.equalTo(imgCC.snp.centerY).offset(2)
            make.leading.equalTo(imgRS.snp.trailing).offset(12)
        }

        picCC.snp.makeConstraints { make in
            make.top.equalTo(imgCC.snp.bottom).offset(11)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(253)
        }

        contentLabelCC.snp.makeConstraints { make in
            make.top.equalTo(picCC.snp.bottom).offset(13)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
        }

        lineView6.snp.makeConstraints { make in
            make.top.equalTo(contentLabelCC.snp.bottom).offset(32)
            make.height.equalTo(0.5)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
        }

        imgRS.snp.makeConstraints { make in
            make.top.equalTo(lineView4.snp.bottom).offset(32)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.height.width.equalTo(44)
        }

        titleLabelRS.snp.makeConstraints { make in
            make.bottom.equalTo(imgRS.snp.centerY).offset(-2)
            make.leading.equalTo(imgRS.snp.trailing).offset(12)
        }

        descriptionRS.snp.makeConstraints { make in
            make.top.equalTo(imgRS.snp.centerY).offset(2)
            make.leading.equalTo(imgRS.snp.trailing).offset(12)
        }

        picRS.snp.makeConstraints { make in
            make.top.equalTo(imgRS.snp.bottom).offset(11)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(253)
        }

        contentLabelRS.snp.makeConstraints { make in
            make.top.equalTo(picRS.snp.bottom).offset(13)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
        }

        lineView5.snp.makeConstraints { make in
            make.top.equalTo(contentLabelRS.snp.bottom).offset(32)
            make.height.equalTo(0.5)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
        }

        imgBol.snp.makeConstraints { make in
            make.top.equalTo(lineView3.snp.bottom).offset(32)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.height.width.equalTo(44)
        }

        titleLabelBol.snp.makeConstraints { make in
            make.bottom.equalTo(imgBol.snp.centerY).offset(-2)
            make.leading.equalTo(imgBol.snp.trailing).offset(12)
        }

        descriptionBol.snp.makeConstraints { make in
            make.top.equalTo(imgBol.snp.centerY).offset(2)
            make.leading.equalTo(imgBol.snp.trailing).offset(12)
        }

        picBol.snp.makeConstraints { make in
            make.top.equalTo(imgBol.snp.bottom).offset(11)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(253)
        }

        contentLabelBol.snp.makeConstraints { make in
            make.top.equalTo(picBol.snp.bottom).offset(13)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
        }

        lineView4.snp.makeConstraints { make in
            make.top.equalTo(contentLabelBol.snp.bottom).offset(32)
            make.height.equalTo(0.5)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
        }

        imgSto.snp.makeConstraints { make in
            make.top.equalTo(lineView2.snp.bottom).offset(32)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.height.width.equalTo(44)
        }

        titleLabelSto.snp.makeConstraints { make in
            make.bottom.equalTo(imgSto.snp.centerY).offset(-2)
            make.leading.equalTo(imgSto.snp.trailing).offset(12)
        }

        descriptionSto.snp.makeConstraints { make in
            make.top.equalTo(imgSto.snp.centerY).offset(2)
            make.leading.equalTo(imgSto.snp.trailing).offset(12)
        }

        picSto.snp.makeConstraints { make in
            make.top.equalTo(imgSto.snp.bottom).offset(11)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(253)
        }

        contentLabelSto.snp.makeConstraints { make in
            make.top.equalTo(picSto.snp.bottom).offset(13)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
        }

        lineView3.snp.makeConstraints { make in
            make.top.equalTo(contentLabelSto.snp.bottom).offset(32)
            make.height.equalTo(0.5)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
        }

        imgMac.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(32)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.height.width.equalTo(44)
        }

        titleLabelMac.snp.makeConstraints { make in
            make.bottom.equalTo(imgMac.snp.centerY).offset(-2)
            make.leading.equalTo(imgMac.snp.trailing).offset(12)
        }

        descriptionMac.snp.makeConstraints { make in
            make.top.equalTo(imgMac.snp.centerY).offset(2)
            make.leading.equalTo(imgMac.snp.trailing).offset(12)
        }

        picMac.snp.makeConstraints { make in
            make.top.equalTo(imgMac.snp.bottom).offset(11)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(253)
        }

        contentLabelMac.snp.makeConstraints { make in
            make.top.equalTo(picMac.snp.bottom).offset(13)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
        }

        lineView2.snp.makeConstraints { make in
            make.top.equalTo(contentLabelMac.snp.bottom).offset(32)
            make.height.equalTo(0.5)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
        }

        lineView.snp.makeConstraints { make in
            make.top.equalTo(bgViewSummary.snp.bottom).offset(32)
            make.height.equalTo(0.5)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
        }

        imgSum.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.top).offset(18)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.height.width.equalTo(44)
        }

        titleLabelSum.snp.makeConstraints { make in
            make.top.equalTo(imgSum.snp.top)
            make.leading.equalTo(imgSum.snp.trailing).offset(12)
        }

        picSum.snp.makeConstraints { make in
            make.top.equalTo(imgSum.snp.bottom).offset(11)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(292)
        }

        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(picSum.snp.bottom).offset(13)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
        }

        bgViewSummary.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(13)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
            make.bottom.equalTo(bgContent2.snp.bottom).offset(13)
        }

        bgContent2.snp.makeConstraints { make in
            make.top.equalTo(bgTitle2.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        bgTitle2.snp.makeConstraints { make in
            make.top.equalTo(bgContent1.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        bgContent1.snp.makeConstraints { make in
            make.top.equalTo(bgTitle1.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        bgTitle1.snp.makeConstraints { make in
            make.top.equalTo(bgViewSummary.snp.top).offset(13)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        scrollView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(6)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
        }

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        leftBarButton.translatesAutoresizingMaskIntoConstraints = false
        leftBarButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
        leftBarButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
        leftBarButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        leftBarButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
    }
}

extension StrategyController {
    @objc private func didLeftBarButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
}
