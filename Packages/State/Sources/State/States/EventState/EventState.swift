public struct EventState: Equatable {
    
    // MARK: - Properties
    
    public var loggedUserEvents: [Event]
    public var usersEvents: [User: [Event]]
    public var feedEvents: [Event]
    
    // MARK: - Lifecycle
    
    public init(
        loggedUserEvents: [Event] = [],
        usersEvents: [User : [Event]] = [:],
        feedEvents: [Event] = []
    ) {
        self.loggedUserEvents = loggedUserEvents
        self.usersEvents = usersEvents
        self.feedEvents = feedEvents
    }
}
