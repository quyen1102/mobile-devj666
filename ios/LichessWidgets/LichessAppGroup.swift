import Foundation

enum LichessAppGroup {
    static let id = "group.com.example.base.widgets"

    // Keys must match the strings passed to HomeWidget.saveWidgetData in lib/src/app.dart.
    static let usernameKey = "username"
    static let lastUpdatedKey = "lastUpdated"

    static var username: String {
        UserDefaults(suiteName: id)?.string(forKey: usernameKey) ?? "Guest"
    }

    static var lastUpdated: String {
        UserDefaults(suiteName: id)?.string(forKey: lastUpdatedKey) ?? "Never"
    }
}
