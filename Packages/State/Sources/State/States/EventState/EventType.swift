public enum EventType: String, Codable, CaseIterable, Hashable {
    
    // MARK: - Cases
    
    case privatized
    case open
    
    // MARK: - Properties
    
    public var title: String {
        switch self {
        case .privatized: return "Private"
        case .open: return "Open"
        }
    }
    
    public var description: String {
        switch self {
        case .privatized: return "Private events can be seen only by the people you invite."
        case .open: return "Open events can be seen by all users"
        }
    }
}
