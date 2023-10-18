import Common

public struct AuthState: Equatable {
    
    // MARK: - Properties
    
    public var user: Loadable<User>
    
    // MARK: - Lifecycle
    
    public init(user: Loadable<User> = .initial) {
        self.user = user
    }
    
    // MARK: - Equatable
    
    public static func == (lhs: AuthState, rhs: AuthState) -> Bool {
        lhs.user.data?.username == rhs.user.data?.username ? true : false
    }
}
