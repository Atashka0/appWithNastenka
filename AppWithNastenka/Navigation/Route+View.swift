import State
import SwiftUI

extension Route {
    @ViewBuilder var view: some View {
        switch self {
        case .blue: BlueView()
        case .yellow: YellowView()
        }
    }
}
