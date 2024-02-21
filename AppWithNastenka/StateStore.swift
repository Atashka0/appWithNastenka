import ReSwift
import Middleware
import APIManager
import State

public var stateStore = Store<AppState>(
    reducer: appReducer,
    state: AppState(),
    middleware: [authMiddleware(authManager: AuthManager()), eventMiddleware(eventManager: EventManager())]
)
