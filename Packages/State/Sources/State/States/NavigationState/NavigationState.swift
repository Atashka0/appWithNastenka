public struct NavigationState {
    
    // MARK: - Properties
    
    public var path: [Route]
    public var root: Route
    
    // MARK: - Lifecycle
    
    public init(
        path: [Route] = [],
        root: Route = .yellow
    ) {
        self.path = path
        self.root = root
    }
}
