import ReSwift

public func appReducer(action: Action, state: AppState?) -> AppState {
    AppState(
        navigationState: navigationReducer(action: action, state: state?.navigationState)
    )
}
