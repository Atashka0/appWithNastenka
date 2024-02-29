import SwiftUI

struct CustomSecureField: View {
    let placeholder: String
    var imageName: String?
    var rightView: String
    @Binding var text: String
    @State private var isPasswordVisible: Bool = false
    var body: some View {
        HStack {
            if let imageName = imageName {
                Image(systemName: imageName)
                    .foregroundColor(.gray)
                    .padding(.leading)
            }
            if isPasswordVisible {
                TextField(placeholder, text: $text)
            } else {
                SecureField(placeholder, text: $text)
            }
            Button {
                isPasswordVisible.toggle()
            } label: {
                Image(rightView)
                    .resizable()
                    .frame(width: Constants.rightImageWidth, height: Constants.rightImageHeight)
                    .foregroundColor(
                        !isPasswordVisible ? .gray : ColorScheme.grayAndLemonYellow
                    )
            }
        }
        .frame(height: Constants.inputViewHeight)
    }
}

private struct Constants {
    static let rightImageWidth: CGFloat = 20
    static let rightImageHeight: CGFloat = 9
    static let inputViewHeight: CGFloat = 45
}
