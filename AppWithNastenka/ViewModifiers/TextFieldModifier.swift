import SwiftUI

struct TextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Jost-Regular", size: 15))
            .padding()
            .frame(height: 45)
            .background(Color(.systemGray5))
            .overlay(RoundedRectangle(cornerRadius: GlobalConstants.textFieldCornerRadius).stroke(Color(uiColor: .systemGray5)))
            .clipShape(RoundedRectangle(cornerRadius: GlobalConstants.textFieldCornerRadius))
    }
}


