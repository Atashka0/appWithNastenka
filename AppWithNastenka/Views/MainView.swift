import SwiftUI
import State
import ReSwift

enum MainViewType: Int, CaseIterable {
    case list
    case map
    var title: String {
        switch self {
        case .map: return "Map"
        case .list: return "List"
        }
    }
}

struct MainView: View {
    @ObservedObject var authController: AuthController
    @ObservedObject var eventController: EventController
    
    @State var selectedView: MainViewType = .list
    var body: some View {
        VStack {
            HStack {
                ForEach(MainViewType.allCases, id: \.rawValue) { item in
                    ZStack {
                        RoundedRectangle(cornerRadius:  GlobalConstants.defaultCornerRadius)
                            .fill(selectedView == item ? ColorScheme.darkGray : Color.black)
                            .frame(width: MainView.Dimensions.tabWidth, height: MainView.Dimensions.tabHeight)
                        
                        
                        Text(item.title)
                            .frame(width: MainView.Dimensions.textWidth, height: MainView.Dimensions.textHeight)
                            .font(Font.custom(FontNames.jostLight, size: GlobalConstants.smallFontSize))
                        
                    }
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            self.selectedView = item
                        }
                    }
                    
                }
                Spacer()
                Image(systemName: MainView.Images.magnifyingGlass)
                    .imageScale(.large)
                    .padding(.horizontal)
                Text("Invites")
            }
            switch selectedView {
            case .list:
                ScrollView {
                    VStack {
                        EventView(event: Event(username: "margo_april", name: "Halloween costume party", date: "October  31,  2023", characteristics: [Characteristic(name: "90's party", description: "blabla")]))
                        Spacer()
                        EventView(event: Event(username: "valeria_syropyatova", name: "Margo’s BD", date: "April  11,  2024", characteristics: [Characteristic(name: "90's party", description: "blabla")]))
                    }
                }
            case .map:
                Spacer()
                Text("Coming soon...")
            }
            Spacer()
            HStack {
                Image(systemName: MainView.Images.plusCircle)
                    .scaleEffect(MainView.Dimensions.imageScale)
                    .onTapGesture {
                        stateStore.dispatch(NavigationAction.setSheet(.createEvent))
                    }
                Spacer()
                Image(systemName: MainView.Images.circle)
                    .scaleEffect(MainView.Dimensions.imageScale)
            }
            .padding(.horizontal)
        }
        .font(Font.custom(FontNames.jostRegular, size: GlobalConstants.fontSize))
        .padding(MainView.Dimensions.edgePadding)
    }
}

extension MainView {
    struct Dimensions {
        static let tabHeight: CGFloat =  35
        static let tabWidth: CGFloat =  50
        static let textHeight: CGFloat =  25
        static let textWidth: CGFloat =  30
        static let imageScale: CGSize = CGSize(width:  1.7, height:  1.7)
        static let edgePadding: CGFloat = 7
    }
    
    struct Images {
        static let magnifyingGlass = "magnifyingglass"
        static let plusCircle = "plus.circle"
        static let circle = "circle"
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(authController: AuthController(), eventController: EventController())
    }
}
