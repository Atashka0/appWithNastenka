import SwiftUI

struct TextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom(FontNames.jostRegular, size: GlobalConstants.textSize))
            .padding()
            .frame(height: Constants.textFieldHeight)
            .overlay(RoundedRectangle(
                cornerRadius: GlobalConstants.textFieldCornerRadius
            ).stroke(Color(uiColor: .systemGray6), lineWidth: Constants.textFieldBorderLineWidth))
            .clipShape(RoundedRectangle(cornerRadius: GlobalConstants.textFieldCornerRadius))
    }
}

private struct Constants {
    static let textFieldHeight: CGFloat = 45
    static let textFieldBorderLineWidth: CGFloat = 3
}


