import ReSwift
import Common

public enum AuthAction: Action {
    case fetchUser(String, String)
    case registerUser(String, String, String)
    case setUser(Loadable<User>)
    case logOut
}
