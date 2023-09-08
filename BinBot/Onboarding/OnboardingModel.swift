import UIKit

struct OnboardingModel {
    var title: String
    var description: String
    var imgProgress: UIImage
    var img: UIImage?


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
