import SwiftUI
import State

struct BlueView: View {
    var body: some View {
        ZStack {
            Color.blue
                .ignoresSafeArea()
            Button {
                stateStore.dispatch(NavigationAction.pop)
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(height: 50)
                        .padding(.horizontal)
                        .foregroundColor(.white)
                    Text("Go back")
                }
            }

        }
    }
}

struct BlueView_Previews: PreviewProvider {
    static var previews: some View {
        BlueView()
    }
}
