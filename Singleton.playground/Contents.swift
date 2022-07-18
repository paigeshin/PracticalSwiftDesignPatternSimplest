import UIKit
import CoreGraphics

enum ThemeSetting {
    
    case darkMode, lightMode
    
    var description: String {
        switch self {
        case .darkMode:
            return "Dark Mode is active"
        case .lightMode:
            return "Light Mode is active"
        }
    }
    
}

class Settings {
    
    static let shared = Settings()
    
    private(set) var theme: ThemeSetting = .lightMode
    private(set) var font = UIFont.systemFont(ofSize: 12)
    
    private init() {}
    
    func changeTheme(to theme: ThemeSetting) {
        self.theme = theme
    }
    
    func changeFontSize(to fontSize: Int) {
        self.font = UIFont.systemFont(ofSize: CGFloat(fontSize))
    }
    
}

Settings.shared.theme.description
Settings.shared.changeTheme(to: .darkMode)
Settings.shared.theme.description
