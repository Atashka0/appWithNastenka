import Foundation
import State
import ReSwift
import SwiftUI

final class NavigationController: ObservableObject {
    @Published var root: Route = .yellow
    @Published var path: [Route] = []
    
    @ViewBuilder
    func view(for route: Route) -> some View {
        route.view
    }
}

extension NavigationController: StoreSubscriber {
    typealias StoreSubscriberStateType = AppState
    
    func newState(state: StoreSubscriberStateType) {
        root = state.navigationState.root
        path = state.navigationState.path
    }
}
