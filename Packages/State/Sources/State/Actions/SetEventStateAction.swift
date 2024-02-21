import ReSwift

/// Вызываются после похода в бек для установки нового стейта. Не нужно вызывать руками.
public enum SetEventStateAction: Action {
    case setLoggedUserEvents([Event])
    case addLoggedUserEvent(Event)
    /// Приходит обновленный ивент со старым айди
    case setChangedEvent(Event)
    case removeLoggedUserEvent(Event)
    case setFeedEvents([Event])
    case setUserEvents(User, [Event])
}
