import SwiftUI

struct TextFieldModifier: ViewModifier {
    var textFieldHeight: CGFloat = 45
    var strokeColor: Color = Color(uiColor: .systemGray5)
    func body(content: Content) -> some View {
        content
            .font(Font.custom(FontNames.jostRegular, size: GlobalConstants.fontSize))
            .padding()
            .frame(height: textFieldHeight)
            .overlay(RoundedRectangle(
                cornerRadius: GlobalConstants.textFieldCornerRadius
            ).stroke(strokeColor, lineWidth: Constants.textFieldBorderLineWidth))
            .clipShape(RoundedRectangle(cornerRadius: GlobalConstants.textFieldCornerRadius))
    }
}

private struct Constants {
    static let textFieldBorderLineWidth: CGFloat = 3
}


struct TextArea: View {
    @Binding var text: String
    let placeholder: String
    
    init(placeholder: String, text: Binding<String>) {
        self.placeholder = placeholder
        self._text = text
        UITextView.appearance().backgroundColor = .black
    }
    var body: some View {
        ZStack (alignment: .topLeading) {
            if text.isEmpty {
                Text(placeholder)
                    .foregroundStyle(Color(uiColor: .systemGray6))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 12)
            }
            TextEditor(text: $text)
                .foregroundStyle(.white)
                .padding(4)
        }
        .overlay(RoundedRectangle(
            cornerRadius: GlobalConstants.textFieldCornerRadius
        ).stroke(Color(uiColor: .systemGray6), lineWidth: 2))
    }
}


