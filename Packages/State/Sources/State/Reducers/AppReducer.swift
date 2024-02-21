import ReSwift

/// Обновляет стейт приложения.
/// Внутри отправляет экшен под-стейтам и обновляет каждый из них.
public func appReducer(action: Action, state: AppState?) -> AppState {
    AppState(
        navigationState: navigationReducer(action: action, state: state?.navigationState),
        authState: authReducer(action: action, state: state?.authState),
        eventState: eventReducer(action: action, state: state?.eventState)
    )
}
