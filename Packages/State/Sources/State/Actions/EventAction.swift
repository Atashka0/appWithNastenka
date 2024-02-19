import ReSwift

public enum EventAction: Action {
    case createEvent(Event)
    case removeUserEvent(User, Event)
    // TODO: edit event action
    case getFeedEvents(User)
    case getUserEvents(User)
}
