public struct EventState: Equatable {
    
    // MARK: - Properties
    
    public var loggedUserEvents: [Event]
    public var usersEvents: [User: [Event]]
    public var feedEvents: [Event]
    public var error: WithMeError?
    
    // MARK: - Lifecycle
    
    public init(
        loggedUserEvents: [Event] = [],
        usersEvents: [User : [Event]] = [:],
        feedEvents: [Event] = [],
        error: WithMeError? = nil
    ) {
        self.loggedUserEvents = loggedUserEvents
        self.usersEvents = usersEvents
        self.feedEvents = feedEvents
        self.error = error
    }
}
