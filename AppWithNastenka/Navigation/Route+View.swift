import State
import SwiftUI

extension Route {
    @ViewBuilder var view: some View {
        switch self {
        case .reg: RegistrationView()
        case .login: LoginView()
        case .main: MainView()
        }
    }
}
