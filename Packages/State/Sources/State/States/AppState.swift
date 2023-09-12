public struct AppState {
    
    // MARK: - Substates
    
    public var navigationState: NavigationState
    public var authState: AuthState
    
    // MARK: - Lifecycle
    
    public init(
        navigationState: NavigationState = NavigationState(),
        authState: AuthState = AuthState()
    ) {
        self.navigationState = navigationState
        self.authState = authState
    }
}
