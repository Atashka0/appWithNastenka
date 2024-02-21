import ReSwift

public enum EventAction: Action {
    case createEvent(Event)
    case removeUserEvent(User, Event)
    case changeEvent(Event)
    case getFeedEvents(User)
    case getUserEvents(User)
}
