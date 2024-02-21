public struct Event: Codable, Hashable {
    
    // MARK: - Properties
    
    public var id: Int
    public var username: String
    public var name: String
    public var place: String
    public var description: String
    public var date: String
    public var characteristics: [Characteristic]
    public var participants: [User]
    public var type: EventType
    
    // MARK: - Lifecycle
    
    public init(
        id: Int = 0,
        username: String = "",
        name: String = "",
        place: String = "",
        description: String = "",
        date: String = "",
        characteristics: [Characteristic] = [],
        participants: [User] = [],
        type: EventType = .privatized
    ) {
        self.id = id
        self.username = username
        self.name = name
        self.place = place
        self.description = description
        self.date = date
        self.characteristics = characteristics
        self.participants = participants
        self.type = type
    }
}
