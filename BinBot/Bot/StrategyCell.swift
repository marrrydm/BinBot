import UIKit

class StrategyCell: UITableViewCell {
    static let id = "Cell"

    private let buttonSelected: UIView = {
        let view = UIView()
        return view
    }()

    var titleLabel: UILabel = {
        var pairLabel = UILabel()
        pairLabel.textColor = UIColor(red: 0.165, green: 0.169, blue: 0.188, alpha: 1)
        pairLabel.font = .systemFont(ofSize: 13, weight: .bold)
        pairLabel.textAlignment = .left
        pairLabel.numberOfLines = 0
        pairLabel.lineBreakMode = .byWordWrapping
        return pairLabel
    }()

    var descriptionLabel: UILabel = {
        var durationLabel = UILabel()
        durationLabel.textColor = UIColor(red: 0.165, green: 0.169, blue: 0.188, alpha: 1)
        durationLabel.font = .systemFont(ofSize: 11, weight: .regular)
        durationLabel.textAlignment = .left
        durationLabel.numberOfLines = 0
        durationLabel.lineBreakMode = .byWordWrapping
        return durationLabel
    }()

    var imgCheck: UIImageView = {
        var imgCheck = UIImageView()
        imgCheck.contentMode = .scaleAspectFit
        return imgCheck
    }()

    var img: UIImageView = {
        var img = UIImageView()
        img.contentMode = .scaleAspectFit
        return img
    }()

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        configureUI()
        self.backgroundColor = UIColor(red: 0.584, green: 0.612, blue: 0.663, alpha: 1)
        self.layer.cornerRadius = 10
    }

    func setup(data: (String, String, UIImage?, UIImage?), selected: Bool) {
        titleLabel.text = data.0
        descriptionLabel.text = data.1
        img.image = data.3
        imgCheck.image = data.2
        if selected {
            self.backgroundColor = UIColor(red: 1, green: 0.855, blue: 0.267, alpha: 1)
            imgCheck.image = UIImage(named: "iconCheck1")
        } else {
            self.backgroundColor = UIColor(red: 0.584, green: 0.612, blue: 0.663, alpha: 1)
            imgCheck.image = UIImage(named: "whiteCircle")
        }
    }

    private func configureUI() {
        buttonSelected.isHidden = true
        contentView.addSubviews(buttonSelected, img, imgCheck, titleLabel, descriptionLabel)

        buttonSelected.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(13)
            make.leading.equalTo(img.snp.trailing).offset(12)
            make.trailing.equalTo(imgCheck.snp.leading).offset(-16)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(2)
            make.leading.equalTo(img.snp.trailing).offset(12)
            make.trailing.equalTo(imgCheck.snp.leading).offset(-16)
        }

        img.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(13)
            make.leading.equalToSuperview().offset(16)
            make.height.width.equalTo(44)
        }

        imgCheck.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(13)
            make.trailing.equalToSuperview().inset(16)
            make.height.width.equalTo(20)
        }
    }
}
