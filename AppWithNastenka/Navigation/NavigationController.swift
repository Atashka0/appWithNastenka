import Foundation
import State
import ReSwift
import SwiftUI

final class NavigationController: ObservableObject {
    @Published var root: Route = .yellow
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
        route.view
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
    typealias StoreSubscriberStateType = NavigationState
    
    func newState(state: StoreSubscriberStateType) {
        pathInState = state.path
        root = state.root
        path = state.path
    }
}
