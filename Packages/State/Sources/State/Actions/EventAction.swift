import ReSwift

public enum EventAction: Action {
    case createEvent(Event)
    case removeUserEvent(User, Event)
    case editEvent(Event)
    case getFeedEvents(User)
    case getUserEvents(User)
}
