import State
import ReSwift
import SwiftUI
import Common

/// Получает обновление стейта и публикует юзера для подписанных на контроллер вью.
public class AuthController: ObservableObject {
    @Published var user: Loadable<User>
    
    public init(user: Loadable<User> = .initial) {
        self.user = user
        stateStore.subscribe(self) { subscription in
            subscription.select { state in
                AuthState(
                    user: state.authState.user
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
            if self.user.data != nil {
                stateStore.dispatch(NavigationAction.setOverlay(nil))
            }
        }
    }
}
