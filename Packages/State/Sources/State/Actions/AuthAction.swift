import ReSwift
import Common

public enum AuthAction: Action {
    case fetchUser(String)
    case setUser(Loadable<User>)
    case logOut
}
