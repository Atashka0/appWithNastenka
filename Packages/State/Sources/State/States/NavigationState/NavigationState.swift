public struct NavigationState: Equatable {
    
    // MARK: - Properties
    
    public var path: [Route]
    public var root: Route
    public var sheet: Route?
    public var overlay: Route?
    
    // MARK: - Lifecycle
    
    public init(
        path: [Route] = [],
        root: Route = .main,
        sheet: Route? = nil,
        overlay: Route? = nil
    ) {
        self.path = path
        self.root = root
        self.sheet = sheet
        self.overlay = overlay
    }
}
