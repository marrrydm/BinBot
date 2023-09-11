import UIKit

final class StaticContent {
    static let shared = StaticContent()

    private(set) var arrayData = [
        OnboardingModel(title: "onb1.title".localize(), description: "onb1.content".localize(), imgProgress: UIImage(named: "control1")!, img: UIImage(named: "onb1")),
        OnboardingModel(title: "onb2.title".localize(), description: "onb2.content".localize(), imgProgress: UIImage(named: "control2")!, img: UIImage(named: "onb2")),
        OnboardingModel(title: "onb3.title".localize(), description: "onb3.content".localize(), imgProgress: UIImage(named: "control3")!, img: UIImage(named: "onb3")),
        OnboardingModel(title: "onb4.title".localize(), description: "onb4.content".localize(), imgProgress: UIImage(named: "control4")!, img: UIImage(named: "onb4")),
        OnboardingModel(title: "onb5.title".localize(), description: "onb5.content".localize(), imgProgress: UIImage(named: "control5")!, img: UIImage(named: "onb5")),
        OnboardingModel(title: "onb6.title".localize(), description: "onb6.content".localize(), imgProgress: UIImage(named: "control6")!, img: UIImage(named: "onb6"))
    ]

    private(set) var arrayPairs =
    [
        ("EUR/USD", UIImage(named: "EUR:USD")),
        ("GBP/USD", UIImage(named: "GBP:USD")),
        ("EUR/CAD", UIImage(named: "EUR:CAD")),
        ("AUD/CAD", UIImage(named: "AUD:CAD")),
        ("EUR/GBP", UIImage(named: "EUR:GBP")),
        ("AUD/JPY", UIImage(named: "AUD:JPY")),
        ("EUR/JPY", UIImage(named: "EUR:JPY")),
        ("USD/JPY", UIImage(named: "USD:JPY")),
        ("CAD/CHF", UIImage(named: "CAD:CHF")),
        ("NZD/USD", UIImage(named: "NZD:USD")),
        ("USD/CAD", UIImage(named: "USD:CAD")),
        ("AUD/USD", UIImage(named: "AUD:USD")),
        ("USD/CHF", UIImage(named: "USD:CHF")),
        ("CAD/JPY", UIImage(named: "CAD:JPY")),
        ("EUR/CHF", UIImage(named: "EUR:CHF")),
        ("GBP/AUD", UIImage(named: "GBP:AUD")),
        ("GBP/JPY", UIImage(named: "GBP:JPY")),
        ("NZD/JPY", UIImage(named: "NZD:JPY")),
        ("GBP/CHF", UIImage(named: "GBR:CHF"))
    ]

    private(set) var lessonsArray: [[(String, Bool, UIImage?)]] =
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

    private init() {

    }
}
