public struct AppState {
    
    // MARK: - Substates
    
    public var navigationState: NavigationState
    public var authState: AuthState
    public var eventState: EventState
    
    // MARK: - Lifecycle
    
    public init(
        navigationState: NavigationState = NavigationState(),
        authState: AuthState = AuthState(),
        eventState: EventState = EventState()
    ) {
        self.navigationState = navigationState
        self.authState = authState
        self.eventState = eventState
    }
}
