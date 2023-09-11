import UIKit

struct OnboardingModel {
    let title: String
    let description: String
    let imgProgress: UIImage
    let img: UIImage?

    init(title: String, description: String, imgProgress: UIImage, img: UIImage?) {
        self.title = title
        self.description = description
        self.imgProgress = imgProgress
        self.img = img
    }
}

public extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}

extension String {
    func localize() -> String {
        return NSLocalizedString(self, comment: "")
    }
}
