import SwiftUI
import RegexBuilder
import State
import Combine

struct RegistrationView: View {
    @EnvironmentObject var authController: AuthController
    
    @State var email: String = ""
    @State var username: String = ""
    @State var password: String = ""
    @State var passwordVerification: String = ""
    @State var passwordMismatch: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: geometry.size.height * RegLogConstants.verticalSpacing) {
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
                        width: geometry.size.width * RegLogConstants.logoSize,
                        height: geometry.size.height * RegLogConstants.logoSize
                    )
                    .padding(.vertical, geometry.size.height * RegLogConstants.logoVerticalPadding)
                    .foregroundColor(Color("black-lemonYellow"))
                VStack {
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
                Text(passwordMismatch ? "Passwords do not match" : "")
                    .font(Font.custom(FontNames.jostRegular, size: GlobalConstants.fontSize))
                    .foregroundColor(.red)
                Button {
                    stateStore.dispatch(AuthAction.registerUser(email, username, password))
                    if authController.user.data != nil {
                        stateStore.dispatch(NavigationAction.setOverlay(nil))
                    }
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
                .padding(.bottom, geometry.size.height * RegLogConstants.bottomViewBottomPadding)
                .padding(.top, geometry.size.height * RegLogConstants.bottomViewTopPadding)
            }
            .padding(.horizontal)
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
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


