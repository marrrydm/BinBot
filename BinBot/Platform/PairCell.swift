import UIKit

class PairCell: UICollectionViewCell {
    static let id = "Cell"

    var pairLabel: UILabel = {
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

    private var checkImg: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "unchecked")
        return view
    }()

    private var arrImgPairs: [(String, UIImage?)] = [
        ("EUR/USD", UIImage(named: "EUR:USD")),
        ("GBP/USD", UIImage(named: "GBP:USD")),
        ("EUR/CAD", UIImage(named: "EUR:CAD")),
        ("AUD/CHF", UIImage(named: "AUD:CHF")),
        ("AUD/CAD", UIImage(named: "AUD:CAD")),
        ("EUR/GBP", UIImage(named: "EUR:GBP")),
        ("AUD/JPY", UIImage(named: "AUD:JPY")),
        ("EUR/JPY", UIImage(named: "EUR:JPY")),
        ("USD/JPY", UIImage(named: "USD:JPY")),
        ("CAD/CHF", UIImage(named: "CAD:CHF")),
        ("NZD/USD", UIImage(named: "NZD:USD")),
        ("USD/CAD", UIImage(named: "USD:CAD")),
        ("AUD/USD", UIImage(named: "AUD:USD")),
        ("CAD/JPY", UIImage(named: "CAD:JPY")),
        // нужны ли?
        ("GBP/CHF", UIImage(named: "GBR:CHF")),
        ("GBP/AUD", UIImage(named: "GBP:AUD")),
        ("GBP/JPY", UIImage(named: "GBP:JPY")),
        ("NZD/JPY", UIImage(named: "NZD:JPY")),
        ("USD/CHF", UIImage(named: "USD:CHF")),
        ("EUR/CHF", UIImage(named: "EUR:CHF"))
    ]

    func configure(pair: String, selected: Bool) {
        self.layer.borderColor = UIColor(red: 0.26, green: 0.276, blue: 0.33, alpha: 1).cgColor
        self.contentView.layer.cornerRadius = 16
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 16
        self.contentView.backgroundColor = selected ? UIColor(red: 0.26, green: 0.276, blue: 0.33, alpha: 1) : .clear

        checkImg.image = selected ? UIImage(named: "check") :  UIImage(named: "unchecked")

        pairLabel.text = pair.prefix(3) + "/" + pair.suffix(3)
        let forImg = pairLabel.text!
        for item in arrImgPairs {
            if item.0 == forImg {
                imgPair.image = item.1
            }
        }
        buttonSelected.isHidden = !selected
        setupView()
    }

    private func setupView() {
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
