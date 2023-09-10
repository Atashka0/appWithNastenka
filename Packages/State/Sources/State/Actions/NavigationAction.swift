import ReSwift

public enum NavigationAction: Action {
    case push(Route)
    case pop
    case setRoot(Route)
    case setPath([Route])
}
