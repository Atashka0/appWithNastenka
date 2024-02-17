import SwiftUI
import State

@main
struct AppWithNastenkaApp: App {
    @StateObject var navigationController = NavigationController()
    @StateObject var authController = AuthController()

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $navigationController.path) {
                navigationController.root.view
                    .navigationDestination(for: Route.self, destination: navigationController.view)
            }
            .onAppear {
                let dispatchGroup = DispatchGroup()
                dispatchGroup.notify(queue: DispatchQueue.main) {
                    if authController.user.data == nil {
                        stateStore.dispatch(NavigationAction.setOverlay(.register))
                    }
                }
                dispatchGroup.enter()
                navigationController.subscribe()
                dispatchGroup.leave()
            }
            .overlay {
                if let overlay = navigationController.overlay {
                    ZStack {
                        Color(.black)
                        overlay.view
                    }
                }
            }
            .sheet(isPresented: $navigationController.isSheetPresented) {
                if let sheet = navigationController.sheet {
                    sheet.view
                }
            }
        }
    }
}
