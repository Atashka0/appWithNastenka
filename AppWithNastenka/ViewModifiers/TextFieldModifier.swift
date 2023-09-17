//
//  TextFieldModifier.swift
//  AppWithNastenka
//
//  Created by Ilyas Kudaibergenov on 17.09.2023.
//

import SwiftUI

struct TextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(height: 45)
            .background(Color(.systemGray5))
            .overlay(RoundedRectangle(cornerRadius: 7).stroke(Color(uiColor: .systemGray5)))
            .clipShape(RoundedRectangle(cornerRadius: 7))
    }
}


