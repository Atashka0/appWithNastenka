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
    static let textFieldBorderLineWidth: CGFloat =  3
}

struct TextArea: View {
    @Binding var text: String
    let placeholder: String
    
    init(placeholder: String, text: Binding<String>) {
        self.placeholder = placeholder
        self._text = text
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            TextEditor(text: $text)
                .foregroundStyle(.white)
            if text.isEmpty {
                Text(placeholder)
                    .padding(.vertical,  12)
                    .foregroundStyle(Color(.systemGray3))
            }
        }
        .padding(.horizontal,  16)
        .overlay(RoundedRectangle(cornerRadius: 5)
            .stroke(ColorScheme.darkGray, lineWidth: 2))
    }
}


struct TextArea_Previews: PreviewProvider {
    static var previews: some View {
        TextArea(placeholder: "Description", text: .constant(""))
    }
}
