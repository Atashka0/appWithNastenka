import ReSwift

/// Принимает на вход экшен и старый стейт.
/// Если пришел экшен ивентов, то обрабатывает его.
/// Возвращает обновленный стейт ивентов.
func eventReducer(action: Action, state: EventState?) -> EventState {
    var state = state ?? EventState()
    
    switch action {
    case let SetEventStateAction.addLoggedUserEvent(event):
        state.loggedUserEvents.append(event)
    case let SetEventStateAction.removeLoggedUserEvent(event):
        state.loggedUserEvents.removeAll { $0 == event }
    case let SetEventStateAction.setLoggedUserEvents(events):
        state.loggedUserEvents = events
    case let SetEventStateAction.setFeedEvents(events):
        state.feedEvents = events
    case let SetEventStateAction.setUserEvents(user, events):
        state.usersEvents[user] = events
    default:
        break
    }
    
    return state
}
