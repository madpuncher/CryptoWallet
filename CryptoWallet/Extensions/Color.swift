import UIKit

extension UIColor {
    static let theme = ThemeColor()
}

struct ThemeColor {
    let accent = UIColor(named: "AccentColor")
    let background = UIColor(named: "BackgroundColor")
    let green = UIColor(named: "GreenColor")
    let red = UIColor(named: "RedColor")
    let secondaryText = UIColor(named: "SecondaryTextColor")
}
