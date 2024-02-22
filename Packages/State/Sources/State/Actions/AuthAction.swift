import ReSwift
import Common

public enum AuthAction: Action {
    case fetchUser(String, String)
    case registerUser(User, String)
    case setUser(Loadable<User>)
    case logOut
    case setError(WithMeError?)
}
