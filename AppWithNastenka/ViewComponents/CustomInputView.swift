import SwiftUI

struct CustomInputView: View {
    let placeholder: String
    var imageName: String?
    var isSecuredField: Bool = false
    @Binding var text: String
    var body: some View {
        HStack {
            if let imageName = imageName {
                Image(systemName: imageName)
                    .foregroundColor(.gray)
                    .padding(.leading)
            }
            if self.isSecuredField {
                SecureField(placeholder, text: $text)
            } else {
                TextField(placeholder,text: $text)
            }
            
        }
        .frame(height: 45)
        .background(Color(.systemGray5))
    }
}
