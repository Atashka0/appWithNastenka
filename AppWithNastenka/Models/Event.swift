import Foundation
import SwiftUI
import State

public struct Event: Codable {
    var username: String = ""
    var name: String = ""
    var place: String = ""
    var description: String = ""
    var date: String = ""
    var characteristics: [Characteristic] = [Characteristic(name: "", description: "")]
    var participants: [User] = []
    var type: EventType = .privatized
}

public struct Characteristic: Codable, Hashable {
    var name: String
    var description: String
}

enum EventType: Int, Codable, CaseIterable {
    case privatized
    case open
    var title: String {
        switch self {
        case .privatized: return "Private"
        case .open: return "Open"
        }
    }
    
    var description: String {
        switch self {
        case .privatized: return "Private events can be seen only by the people you invite."
        case .open: return "Open events can be seen by all users"
        }
    }
}
