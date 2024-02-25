import ReSwift
import Common

/// Принимает на вход экшен и старый стейт.
/// Если пришел экшен авторизации, то обрабатывает его.
/// Возвращает обновленный стейт авторизации.
func authReducer(action: Action, state: AuthState?) -> AuthState {
    var state = state ?? AuthState()
    
    switch action {
    case let AuthAction.setUser(user):
        state.user = user
    case AuthAction.logOut:
        state.user = .initial
    case let AuthAction.setError(error):
        state.error = error
    default:
        break
    }
    
    return state
}
