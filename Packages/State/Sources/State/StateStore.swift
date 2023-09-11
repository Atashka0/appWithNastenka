import ReSwift

public var stateStore = Store<AppState>(
    reducer: appReducer,
    state: AppState()
)
