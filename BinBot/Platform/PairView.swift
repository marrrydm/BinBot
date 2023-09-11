import UIKit

protocol PairDelegate: AnyObject {
    func updatePair(_ value: String?)
}

final class PairViewController: UIViewController {
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.text = "trade.choose".localize()
        view.font = .systemFont(ofSize: 18, weight: .bold)
        view.textColor = .white
        view.textAlignment = .left
        return view
    }()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.register(PairCell.self, forCellWithReuseIdentifier: "PairCell")
        view.showsVerticalScrollIndicator = false
        view.delegate = self
        view.dataSource = self
        return view
    }()

    private lazy var leftBarButton: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "close")
        view.isUserInteractionEnabled = true
        view.contentMode = .scaleAspectFit
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didLeftBarButtonTapped)))
        return view
    }()

    private let pairs = Array(BinBotContent.shared.pairs.keys)

    var pair: String?
    weak var delegate: PairDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = UIColor(red: 0.165, green: 0.169, blue: 0.188, alpha: 1)
        setupUI()
    }
}

private extension PairViewController {
    func setupUI() {
        view.addSubviews(titleLabel, leftBarButton, collectionView)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        leftBarButton.translatesAutoresizingMaskIntoConstraints = false
        leftBarButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
        leftBarButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
        leftBarButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        leftBarButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 28).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 4).isActive = true
    }
}

private extension PairViewController {
    @objc func didLeftBarButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: false)
    }
}

extension PairViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        pair = pairs[indexPath.row]
        collectionView.reloadData()
        delegate?.updatePair(pair)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.navigationController?.popViewController(animated: false)
        }
    }
}

extension PairViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pairs.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PairCell", for: indexPath) as! PairCell
        cell.configure(pair: pairs[indexPath.row], selected: pairs[indexPath.row] == pair)
        return cell
    }
}

extension PairViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: (collectionView.frame.width), height: 48)
    }
}
