public struct Characteristic: Codable, Hashable {
    
    // MARK: - Properties
    
    public var id: Int
    public var name: String
    public var description: String
    
    // MARK: - Lifecycle
    
    public init(
        id: Int = 0,
        name: String = "",
        description: String = ""
    ) {
        self.id = id
        self.name = name
        self.description = description
    }
}
