public struct NavigationState: Equatable {
    
    // MARK: - Properties
    
    public var path: [Route]
    public var root: Route
    
    // MARK: - Lifecycle
    
    public init(
        path: [Route] = [],
        root: Route = .main
    ) {
        self.path = path
        self.root = root
    }
}
