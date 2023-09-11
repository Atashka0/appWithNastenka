import SwiftUI
import State
import ReSwift

struct YellowView: View {
    var body: some View {
        ZStack {
            Color.yellow
                .ignoresSafeArea()
            Button {
                stateStore.dispatch(NavigationAction.push(.blue))
            } label: {
                Text("Go to blue")
            }
        }
    }
}

struct YellowView_Previews: PreviewProvider {
    static var previews: some View {
        YellowView()
    }
}
