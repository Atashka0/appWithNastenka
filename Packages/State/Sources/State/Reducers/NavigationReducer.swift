import ReSwift

func navigationReducer(action: Action, state: NavigationState?) -> NavigationState {
    var state = state ?? NavigationState()
    
    switch action {
    case NavigationAction.push(let route):
        state.path.append(route)
    case NavigationAction.pop:
        if let last = state.path.last, last != state.root {
            state.path.removeLast()
        }
    case NavigationAction.setRoot(let route):
        state.root = route
        state.path = [route]
    case NavigationAction.setPath(let path):
        state.path = path
        state.root = path.first ?? .yellow
    default:
        break
    }
    
    return state
}
