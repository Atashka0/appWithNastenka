public struct Characteristic: Codable, Hashable {
    
    // MARK: - Properties
    
    public var name: String
    public var description: String
    
    // MARK: - Lifecycle
    
    public init(
        name: String = "",
        description: String = ""
    ) {
        self.name = name
        self.description = description
    }
}
