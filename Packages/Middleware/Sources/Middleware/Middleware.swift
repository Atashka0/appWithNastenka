import APIManager
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
                case let .registerUser(user, password):
                    dispatch(AuthAction.setUser(.loading))
                    Task {
                        let result = await authManager.registerUser(user, password: password)
                        switch result {
                        case let .success(user):
                            if let user {
                                dispatch(AuthAction.setUser(.ready(user)))
                                print(user)
                            }
                        case let .failure(error):
                            // TODO: handle error
                            print(error)
                        }
                    }
                default: break
                }
                next(action)
            }
        }
    }
}

public func eventMiddleware(eventManager: EventManager) -> Middleware<AppState> {
    { dispatch, _ in
        { next in
            { action in
                guard let action = action as? EventAction else {
                    next(action)
                    return
                }
                switch action {
                case let .createEvent(event):
                    Task {
                        let result = await eventManager.newEvent(event)
                        switch result {
                        case let .success(event):
                            dispatch(SetEventStateAction.addLoggedUserEvent(event))
                        case let .failure(error):
                            // TODO: handle error
                            print(error)
                        }
                    }
                case let .getFeedEvents(user):
                    Task {
                        let result = await eventManager.getFeedEvents(for: user)
                        switch result {
                        case let .success(events):
                            dispatch(SetEventStateAction.setFeedEvents(events))
                        case let .failure(error):
                            print(error)
                        }
                    }
                case let .getUserEvents(user):
                    Task {
                        let result = await eventManager.getEvents(for: user)
                        switch result {
                        case let .success(events):
                            dispatch(SetEventStateAction.setUserEvents(user, events))
                        case let .failure(error):
                            print(error)
                        }
                    }
                case let .removeUserEvent(user, event):
                    Task {
                        let result = await eventManager.removeUserEvent(user: user, event: event)
                        switch result {
                        case let .success(event):
                            dispatch(SetEventStateAction.removeLoggedUserEvent(event))
                        case let .failure(error):
                            print(error)
                        }
                    }
                case let .changeEvent(event):
                    Task {
                        let result = await eventManager.changeEvent(event)
                        switch result {
                        case let .success(editedEvent):
                            dispatch(SetEventStateAction.setChangedEvent(editedEvent))
                        case let .failure(error):
                            print(error)
                        }
                    }
                }
                next(action)
            }
        }
    }
}
