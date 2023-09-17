//
//  RegistrationView.swift
//  AppWithNastenka
//
//  Created by Ilyas Kudaibergenov on 19.09.2023.
//

import SwiftUI
import RegexBuilder
import State

struct RegistrationView: View {
    @State var email: String = ""
    @State var username: String = ""
    @State var password: String = ""
    @State var passwordVerification: String = ""
    
    var body: some View {
        VStack {
            Spacer()
            Text("With.me")
                .font(.system(size: 45, weight: .bold, design: .rounded))
                .foregroundColor(.black)
                .bold()
            TextField("Email",text: $email)
                .modifier(TextFieldModifier())
            TextField("Username",text: $username)
                .modifier(TextFieldModifier())
            CustomInputView(placeholder: "Password", isSecuredField: true, text: $password)
                .modifier(TextFieldModifier())
            CustomInputView(placeholder: "Confirm Password", isSecuredField: true, text: $passwordVerification)
                .modifier(TextFieldModifier())
            Button {
               //authAction
            } label: {
                Text("Sign up")
                    .modifier(ButtonModifier())
                    .padding(.top, 10)
            }
            
            Spacer()
            
            HStack {
                Text("Already have an account?")
                    .foregroundColor(.black)
                
                Button {
                    stateStore.dispatch(NavigationAction.push(.login))
                } label: {
                    Text("Sign In")
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                }
            }
            .padding(.top)
        }
        .padding(.horizontal)
        
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
            .frame(minWidth: 0, maxWidth: .infinity)
            .frame(height: 45)
            .foregroundColor(.black)
            .background(ColorScheme.lemonYellow)
            .contentShape(Rectangle())
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(uiColor: .systemGray5)))
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}


