import SwiftUI
import State

struct BlueView: View {
    @StateObject var authController = AuthController()
    
    var body: some View {
        ZStack {
            Color.blue
                .ignoresSafeArea()
            VStack {
                Button {
                    stateStore.dispatch(NavigationAction.pop)
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(height: 50)
                            .padding(.horizontal)
                            .foregroundColor(.white)
                        Text("Go back")
                    }
                }
                Button {
                    switch authController.user {
                    case .initial:
                        stateStore.dispatch(AuthAction.fetchUser("email", "password"))
                    case .ready(_):
                        stateStore.dispatch(AuthAction.setUser(.initial))
                    case .loading:
                        break
                    }
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(height: 50)
                            .padding(.horizontal)
                            .foregroundColor(.white)
                        switch authController.user {
                        case .initial:
                            Text("Login")
                        case .loading:
                            Text("...")
                        case .ready(_):
                            Text("Logout")
                        }
                    }
                }
                switch authController.user {
                case .initial:
                    Text("No logged user")
                case .loading:
                    Text("Loading")
                case let .ready(user):
                    Text("Hello, \(user.username)!")
                }
            }

        }
    }
}

struct BlueView_Previews: PreviewProvider {
    static var previews: some View {
        BlueView()
    }
}
