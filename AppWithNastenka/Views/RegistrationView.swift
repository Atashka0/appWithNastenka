import SwiftUI
import RegexBuilder
import State
import Combine

struct RegistrationView: View {
    @ObservedObject var authController: AuthController
    
    @State var email: String = ""
    @State var username: String = ""
    @State var password: String = ""
    @State var passwordVerification: String = ""
    @State var passwordMismatch: Bool = false
    
    var body: some View {
        VStack(spacing: RegLogConstants.verticalSpacing) {
            HStack {
                Spacer()
                Button {
                    stateStore.dispatch(NavigationAction.setOverlay(nil))
                } label: {
                    Image(AssetNames.closeCross)
                        .foregroundStyle(Color.gray)
                }
            }
            Image(AssetNames.logo)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(
                    width: RegLogConstants.logoSize,
                    height: RegLogConstants.logoSize
                )
                .padding(.vertical, RegLogConstants.logoVerticalPadding)
                .foregroundColor(Color("black-lemonYellow"))
            VStack(spacing: RegLogConstants.verticalSpacing) {
                TextField("Email",text: $email)
                    .modifier(TextFieldModifier())
                TextField("Username",text: $username)
                    .modifier(TextFieldModifier())
                CustomSecureField(placeholder: "Password", rightView: AssetNames.eye, text: $password)
                    .modifier(TextFieldModifier())
                CustomSecureField(
                    placeholder: "Confirm Password",
                    rightView: AssetNames.eye,
                    text: $passwordVerification
                )
                .modifier(TextFieldModifier())
                .onReceive(Just(passwordVerification)) { _ in
                    passwordMismatch = password != passwordVerification
                }
            }
            if passwordMismatch {
                Text("Passwords do not match")
                    .font(Font.custom(FontNames.jostRegular, size: GlobalConstants.fontSize))
                    .foregroundColor(.red)
            }
            else if let error = authController.error {
                if case let WithMeError.userInitiatedError(message) = error {
                    Text(message)
                        .font(Font.custom(FontNames.jostRegular, size: GlobalConstants.fontSize))
                        .foregroundColor(.red)
                } else {
                    Text("Oops! something went wrong...")
                        .font(Font.custom(FontNames.jostRegular, size: GlobalConstants.fontSize))
                        .foregroundColor(.red)
                }
            }
            Button {
                stateStore.dispatch(AuthAction.registerUser(User(username: username.lowercased(), email: email.lowercased()), password))
            } label: {
                Text("Sign up")
                    .modifier(ButtonModifier())
                    .opacity(passwordMismatch ? RegLogConstants.disabledOpacity : RegLogConstants.enabledOpacity)
            }
            .disabled(passwordMismatch)
            
            Spacer()
            Divider()
            HStack {
                Text("Already have an account?")
                    .font(Font.custom(FontNames.jostRegular, size: GlobalConstants.fontSize))
                Button {
                    stateStore.dispatch(NavigationAction.setOverlay(.login))
                } label: {
                    Text("Sign In")
                        .font(Font.custom(FontNames.jostSemiBold, size: GlobalConstants.fontSize))
                }
            }
            .foregroundColor(ColorScheme.grayAndWhite)
            .font(.footnote)
        }
        .padding(.horizontal, GlobalConstants.edgePadding)
        .onChange(of: authController.user.data) { userData in
            if userData != nil {
                stateStore.dispatch(NavigationAction.setOverlay(nil))
            }
        }
        .onDisappear {
            if authController.error != nil {
                stateStore.dispatch(AuthAction.setError(nil))
            }
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView(authController: AuthController())
    }
}

public struct ButtonModifier: ViewModifier {
    public func body(content: Content) -> some View {
        content
            .font(Font.custom(FontNames.jostRegular, size: GlobalConstants.fontSize))
            .frame(minWidth: 0, maxWidth: .infinity)
            .frame(height: RegLogConstants.buttonHeight)
            .foregroundColor(.black)
            .background(ColorScheme.lemonYellow)
            .contentShape(Rectangle())
            .overlay(RoundedRectangle(
                cornerRadius: GlobalConstants.buttonCornerRadius)
                .stroke(Color(uiColor: .systemBackground))
            )
            .clipShape(RoundedRectangle(cornerRadius: GlobalConstants.buttonCornerRadius))
    }
}


