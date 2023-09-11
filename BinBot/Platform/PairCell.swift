import UIKit

final class PairCell: UICollectionViewCell {
    static let id = "Cell"

    private let pairLabel: UILabel = {
        var view = UILabel()
        view.textColor = .white
        view.font = .systemFont(ofSize: 15, weight: .bold)
        view.textAlignment = .left
        return view
    }()

    private let buttonSelected: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()

    private let imgPair: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()

    private let checkImg: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()

    func configure(pair: String, selected: Bool) {
        pairLabel.text = pair.prefix(3) + "/" + pair.suffix(3)
        checkImg.image = selected ? UIImage(named: "check") :  UIImage(named: "unchecked")

        guard let pair = pairLabel.text else { return }
        StaticContent.shared.arrayPairs
            .first { $0.0 == pair }
            .map { imgPair.image = $0.1 }

        contentView.backgroundColor = selected ? UIColor(red: 0.26, green: 0.276, blue: 0.33, alpha: 1) : .clear

        buttonSelected.isHidden = !selected
        setupView()
    }
}

private extension PairCell {
    func setupView() {
        self.layer.borderColor = UIColor(red: 0.26, green: 0.276, blue: 0.33, alpha: 1).cgColor
        self.contentView.layer.cornerRadius = 16
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 16

        contentView.addSubviews(pairLabel, imgPair, buttonSelected, checkImg)
        pairLabel.translatesAutoresizingMaskIntoConstraints = false
        checkImg.translatesAutoresizingMaskIntoConstraints = false
        buttonSelected.translatesAutoresizingMaskIntoConstraints = false
        imgPair.translatesAutoresizingMaskIntoConstraints = false

        buttonSelected.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        buttonSelected.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        buttonSelected.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        buttonSelected.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

        pairLabel.leadingAnchor.constraint(equalTo: imgPair.trailingAnchor, constant: 10).isActive = true
        pairLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        pairLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true

        checkImg.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -18).isActive = true
        checkImg.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        checkImg.widthAnchor.constraint(equalToConstant: 20).isActive = true
        checkImg.heightAnchor.constraint(equalToConstant: 20).isActive = true

        imgPair.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        imgPair.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        imgPair.widthAnchor.constraint(equalToConstant: 26).isActive = true
        imgPair.heightAnchor.constraint(equalToConstant: 26).isActive = true
    }
}
