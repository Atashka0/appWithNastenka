import ReSwift
import Middleware
import AuthManager
import State

public var stateStore = Store<AppState>(
    reducer: appReducer,
    state: AppState(),
    middleware: [authMiddleware(authManager: AuthManager())]
)
