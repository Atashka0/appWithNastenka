import Foundation
import SwiftUI
import State

public struct Event {
    var username: String = ""
    var name: String = ""
    var place: String = ""
    var description: String = ""
    var date: String = ""
    var characteristics: [Characteristic] = [Characteristic(name: "", description: "")]
    var participants: [User] = []
    var type: EventType = .privatized
}

public struct Characteristic: Hashable {
    var name: String
    var description: String
}


