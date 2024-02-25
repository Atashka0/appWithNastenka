import ReSwift

/// Принимает на вход экшен и старый стейт.
/// Если пришел экшен навигации, то обрабатывает его.
/// Возвращает обновленный стейт навигации.
func navigationReducer(action: Action, state: NavigationState?) -> NavigationState {
    var state = state ?? NavigationState()
    
    switch action {
    case NavigationAction.push(let route):
        state.path.append(route)
    case NavigationAction.pop:
        if let last = state.path.last, last != state.root {
            _ = state.path.popLast()
        }
    case NavigationAction.setRoot(let route):
        state.root = route
        state.path = [route]
    case NavigationAction.setPath(let path):
        state.path = path
        state.root = path.first ?? .main
    case NavigationAction.setSheet(let route):
        state.sheet = route
    case NavigationAction.setOverlay(let route):
        state.overlay = route
    default:
        break
    }
    
    return state
}
