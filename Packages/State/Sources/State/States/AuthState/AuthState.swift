import Common

public struct AuthState: Equatable {
    
    // MARK: - Properties
    
    public var user: Loadable<User>
    public var error: WithMeError?
    
    // MARK: - Lifecycle
    
    public init(user: Loadable<User> = .initial, error: WithMeError? = nil) {
        self.user = user
        self.error = error
    }
    
    // MARK: - Equatable
    
    public static func == (lhs: AuthState, rhs: AuthState) -> Bool {
        lhs.user.data?.username == rhs.user.data?.username && lhs.error == rhs.error ? true : false
    }
}
