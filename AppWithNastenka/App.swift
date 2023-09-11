import SwiftUI
import State

@main
struct AppWithNastenkaApp: App {
    @StateObject var navigationController = NavigationController()

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $navigationController.path) {
                navigationController.root.view
                    .navigationDestination(for: Route.self, destination: navigationController.view)
            }
            .onAppear {
                navigationController.subscribe()
            }
        }
    }
}
