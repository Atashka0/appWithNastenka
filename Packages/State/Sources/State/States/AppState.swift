public struct AppState {
    
    // MARK: - Substates
    
    public var navigationState: NavigationState
    
    // MARK: - Lifecycle
    
    public init(
        navigationState: NavigationState = NavigationState()
    ) {
        self.navigationState = navigationState
    }
}
