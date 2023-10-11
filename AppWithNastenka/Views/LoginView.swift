import SwiftUI
import State

struct LoginView: View {
    @State var username: String = ""
    @State var password: String = ""
    
    var body: some View {
        VStack {
            Image("logo")
                .resizable()
                .frame(width: 83.5, height: 59.5, alignment: .center)
                .padding(.vertical, 100)
            TextField("Username",text: $username)
                .modifier(TextFieldModifier())
            CustomInputView(placeholder: "Password", isSecuredField: true, text: $password)
                .modifier(TextFieldModifier())
            
            Button {
                //authAction
            } label: {
                Text("Login")
                    .modifier(ButtonModifier())
            }
            
            Spacer()
            
            Divider()
            
            HStack {
                Text("Don't have an account?")
                    .foregroundColor(.black)
                Button {
                    stateStore.dispatch(NavigationAction.pop)
                } label: {
                    Text("Sign Up")
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                }
            }
            .padding(.top)
        }
        .navigationBarBackButtonHidden(true)
        .padding(.horizontal)
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}


