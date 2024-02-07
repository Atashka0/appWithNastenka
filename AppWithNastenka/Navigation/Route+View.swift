import State
import SwiftUI

extension Route {
    @ViewBuilder var view: some View {
        switch self {
        case .register: RegistrationView()
        case .login: LoginView()
        case .main: MainView()
        case .createEvent: CreateEventView()
        }
    }
}
