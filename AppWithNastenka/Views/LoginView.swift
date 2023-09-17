//
//  LoginView.swift
//  AppWithNastenka
//
//  Created by Ilyas Kudaibergenov on 19.09.2023.
//

import SwiftUI
import RegexBuilder
import State

struct LoginView: View {
    @State var username: String = ""
    @State var password: String = ""
    
    var body: some View {
        VStack {
            Spacer()
            Text("With.me")
                .font(.system(size: 45, weight: .bold, design: .rounded))
                .foregroundColor(.black)
                .bold()
            TextField("Username",text: $username)
                .modifier(TextFieldModifier())
            CustomInputView(placeholder: "Password", isSecuredField: true, text: $password)
                .modifier(TextFieldModifier())
            NavigationLink {
                Text("Forgot Password???")
            } label: {
                Text("Forgot Password?")
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            
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


