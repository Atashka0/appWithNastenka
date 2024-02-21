import Foundation
import State
import ReSwift
import SwiftUI

/// Получает обновление стейта и публикует обновленные переменные.
final class NavigationController: ObservableObject {
    var authController: AuthController?
    var eventController: EventController?
    
    @Published var root: Route = .main
    @Published var path: [Route] = [] {
        willSet {
            if newValue != pathInState {
                stateStore.dispatch(NavigationAction.setPath(newValue))
            }
        }
    }
    @Published var sheet: Route? = nil
    @Published var overlay: Route? = nil
    
    var isSheetPresented: Bool {
        get {
            sheet != nil
        }
        set {
            if !newValue {
                stateStore.dispatch(NavigationAction.setSheet(nil))
            }
        }
    }
    
    var pathInState: [Route] = []
    
    @ViewBuilder
    func view(for route: Route) -> some View {
        route.view(
            authController: authController ?? AuthController(),
            eventController: eventController ?? EventController()
        )
        .navigationBarBackButtonHidden()
    }
    
    deinit {
        stateStore.unsubscribe(self)
    }
}

extension NavigationController {
    func subscribe(authController: AuthController, eventController: EventController) {
        self.authController = authController
        self.eventController = eventController
        stateStore.subscribe(self) { subscription in
            subscription.select { state in
                NavigationState(
                    path: state.navigationState.path,
                    root: state.navigationState.root,
                    sheet: state.navigationState.sheet,
                    overlay: state.navigationState.overlay
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
        sheet = state.sheet
        overlay = state.overlay
    }
}
