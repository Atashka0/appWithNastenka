import AuthManager
import ReSwift
import State

public func authMiddleware(authManager: AuthManager) -> Middleware<AppState> {
    { dispatch, _ in
        { next in
            { action in
                guard let action = action as? AuthAction else {
                    next(action)
                    return
                }
                switch action {
                case let .fetchUser(email, password):
                    dispatch(AuthAction.setUser(.loading))
                    Task {
                        let result = await authManager.fetchUser(email: email, password: password)
                        switch result {
                        case let .success(user):
                            if let user {
                                dispatch(AuthAction.setUser(.ready(user)))
                            }
                        case let .failure(error):
                            // TODO: handle error
                            print(error)
                        }
                    }
                case let .registerUser(email, username, password):
                    dispatch(AuthAction.setUser(.loading))
                    Task {
                        let result = await authManager.registerUser(email: email, username: username, password: password)
                        switch result {
                        case let .success(user):
                            if let user {
                                dispatch(AuthAction.setUser(.ready(user)))
                            }
                        case let .failure(error):
                            // TODO: handle error
                            print(error)
                        }
                    }
                case .logOut:
                    dispatch(AuthAction.setUser(.initial))
                    Task {
                        let result = await authManager.logOut()
                        switch result {
                        case .success(_):
                            dispatch(AuthAction.setUser(.initial))
                        case let .failure(error):
                            // TODO: handle error
                            print("Could not logout: ", error)
                        }
                    }
                    
                default: break
                }
                next(action)
            }
        }
    }
}
