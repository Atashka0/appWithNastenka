import State
import SwiftUI

extension Route {
    @ViewBuilder func view(authController: AuthController, eventController: EventController) -> some View {
        switch self {
        case .register: RegistrationView(authController: authController)
        case .login: LoginView(authController: authController)
        case .main: MainView(authController: authController, eventController: eventController)
        case .createEvent: CreateEventView(eventController: eventController)
        }
    }
}
