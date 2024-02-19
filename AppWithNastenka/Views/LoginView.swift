import SwiftUI
import State

struct LoginView: View {
    @EnvironmentObject var authController: AuthController
    @State var email: String = ""
    @State var password: String = ""
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: geometry.size.height * RegLogConstants.verticalSpacing) {
                HStack {
                    Spacer()
                    Button {
                        stateStore.dispatch(NavigationAction.setOverlay(nil))
                    } label: {
                        Image(AssetNames.closeCross)
                            .foregroundStyle(.gray)
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
                    .foregroundColor(ColorScheme.blackAndLemonYellow)
                TextField("Email",text: $email)
                    .modifier(TextFieldModifier())
                CustomSecureField(placeholder: "Password", rightView: AssetNames.eye, text: $password)
                    .modifier(TextFieldModifier())
                
                Button {
                    stateStore.dispatch(AuthAction.fetchUser(email, password))
                    if authController.user.data != nil {
                        stateStore.dispatch(NavigationAction.setOverlay(nil))
                    }
                } label: {
                    Text("Login")
                        .modifier(ButtonModifier())
                }
                
                Button {
                    stateStore.dispatch(NavigationAction.setPath([]))
                } label: {
                    Text("Forgot your password?")
                        .font(Font.custom(FontNames.jostRegular, size: GlobalConstants.fontSize))
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top, geometry.size.height * RegLogConstants.bottomViewBottomPadding)
                }

                
                Spacer()
                Divider()
                HStack {
                    Text("Don't have an account?")
                        .font(Font.custom(FontNames.jostRegular, size: GlobalConstants.fontSize))
                    Button {
                        stateStore.dispatch(NavigationAction.setOverlay(.register))
                        } label: {
                        Text("Sign Up")
                            .font(Font.custom(FontNames.jostSemiBold, size: GlobalConstants.fontSize))
                    }
                }
                .foregroundColor(ColorScheme.grayAndWhite)
                .font(.footnote)
                .padding(.bottom, geometry.size.height * RegLogConstants.bottomViewBottomPadding)
                .padding(.top, geometry.size.height * RegLogConstants.bottomViewTopPadding)
            }
            .navigationBarBackButtonHidden(true)
            .padding(.horizontal)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

struct RegLogConstants {
    static let logoVerticalPadding = 0.07
    static let verticalSpacing = 0.015
    static let bottomViewBottomPadding = 0.01
    static let bottomViewTopPadding = 0.005
    static let logoSize = 0.2
    static let buttonHeight: CGFloat = 50
    static let disabledOpacity: Double = 0.7
    static let enabledOpacity: Double = 1
}
