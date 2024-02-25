import SwiftUI
import ReSwift
import State

/// Получает обновление стейта и публикует ивенты для подписанных на контроллер вью.
public class EventController: ObservableObject {
    @Published var usersEvents: [User: [Event]]
    @Published var loggedUserEvents: [Event]
    @Published var feedEvents: [Event]
    @Published var error: WithMeError?
    
    public init(
        usersEvents: [User: [Event]] = [:],
        loggedUserEvents: [Event] = [],
        feedEvents: [Event] = [],
        error: WithMeError? = nil
    ) {
        self.usersEvents = usersEvents
        self.loggedUserEvents = loggedUserEvents
        self.feedEvents = feedEvents
        self.error = error
        stateStore.subscribe(self) { subscription in
            subscription.select { state in
                EventState(
                    loggedUserEvents: state.eventState.loggedUserEvents,
                    usersEvents: state.eventState.usersEvents,
                    feedEvents: state.eventState.feedEvents,
                    error: state.eventState.error
                )
            }
            .skipRepeats()
        }
    }
    
    deinit {
        stateStore.unsubscribe(self)
    }
}

extension EventController: StoreSubscriber {
    public func newState(state: EventState) {
        DispatchQueue.main.async {
            self.usersEvents = state.usersEvents
            self.feedEvents = state.feedEvents
            self.loggedUserEvents = state.loggedUserEvents
            self.error = state.error
        }
    }
}
