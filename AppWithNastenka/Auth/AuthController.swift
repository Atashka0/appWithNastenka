import State
import ReSwift
import SwiftUI
import Common

/// Получает обновление стейта и публикует юзера для подписанных на контроллер вью.
public class AuthController: ObservableObject {
    @Published var user: Loadable<User>
    @Published var error: WithMeError?
    
    public init(user: Loadable<User> = .initial) {
        self.user = user
        stateStore.subscribe(self) { subscription in
            subscription.select { state in
                AuthState(
                    user: state.authState.user,
                    error: state.authState.error
                )
            }
            .skipRepeats()
        }
    }
    
    deinit {
        stateStore.unsubscribe(self)
    }
}

extension AuthController: StoreSubscriber {
    public func newState(state: AuthState) {
        DispatchQueue.main.async {
            self.user = state.user
            self.error = state.error
        }
    }
}
