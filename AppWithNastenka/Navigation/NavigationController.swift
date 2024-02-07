import Foundation
import State
import ReSwift
import SwiftUI

/// Получает обновление стейта и публикует обновленные переменные.
final class NavigationController: ObservableObject {
    @Published var root: Route = .main
    @Published var path: [Route] = [] {
        willSet {
            if newValue != pathInState {
                stateStore.dispatch(NavigationAction.setPath(newValue))
            }
        }
    }
    
    var pathInState: [Route] = []
    
    @ViewBuilder
    func view(for route: Route) -> some View {
        route.view.navigationBarBackButtonHidden()
    }
    
    deinit {
        stateStore.unsubscribe(self)
    }
}

extension NavigationController {
    func subscribe() {
        stateStore.subscribe(self) { subscription in
            subscription.select { state in
                NavigationState(
                    path: state.navigationState.path,
                    root: state.navigationState.root
                )
            }
            .skipRepeats()
        }
    }
}

extension NavigationController: StoreSubscriber {
    func newState(state: NavigationState) {
        pathInState = state.path
        root = state.root
        path = state.path
    }
}
