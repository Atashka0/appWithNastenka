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
    @State var selectedView: MainViewType = .list
    var body: some View {
        VStack {
            HStack {
                ForEach(MainViewType.allCases, id: \.rawValue) { item in
                    ZStack {
                        RoundedRectangle(cornerRadius:  GlobalConstants.defaultCornerRadius)
                            .fill(selectedView == item ? MainView.Colors.darkGray : Color.black)
                            .frame(width: MainView.Dimensions.tabWidth, height: MainView.Dimensions.tabHeight)
                        
                        
                        Text(item.title)
                            .frame(width: MainView.Dimensions.textWidth, height: MainView.Dimensions.textHeight)
                            .font(Font.custom(FontNames.jostLight, size: GlobalConstants.smallFontSize))
                        
                    }
                    .padding(.leading, MainView.Dimensions.tabLeadingPadding)
                    .padding(.trailing, MainView.Dimensions.tabTrailingPadding)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            self.selectedView = item
                        }
                    }
                    
                }
                Spacer()
                Image(systemName: MainView.Images.magnifyingGlass)
                Text("Invites")
            }
            ScrollView {
                VStack {
                    EventView(event: Event(username: "margo_april", name: "Halloween costume party", date: "October  31,  2023", characteristics: ["90's party", "90's inspired", "Best costume contest"]))
                    Spacer()
                    EventView(event: Event(username: "valeria_syropyatova", name: "Margo’s BD", date: "April  11,  2024", characteristics: ["90's party", "90's inspired", "Best costume contest"]))
                }
            }
            Spacer()
            HStack {
                Image(systemName: MainView.Images.plusCircle)
                    .scaleEffect(MainView.Dimensions.imageScale)
                Spacer()
                Image(systemName: MainView.Images.circle)
                    .scaleEffect(MainView.Dimensions.imageScale)
            }
        }
        .padding()
        .font(Font.custom(FontNames.jostRegular, size: GlobalConstants.textSize))
    }
}

extension MainView {
    struct Colors {
        static let darkGray = Color(red:  18/256, green:  18/256, blue:  18/256)
    }
    
    struct Dimensions {
        static let tabLeadingPadding: CGFloat = -13
        static let tabTrailingPadding: CGFloat = 10
        static let tabHeight: CGFloat =  35
        static let tabWidth: CGFloat =  50
        static let textHeight: CGFloat =  25
        static let textWidth: CGFloat =  30
        static let imageScale: CGSize = CGSize(width:  1.5, height:  1.5)
    }
    
    struct Images {
        static let magnifyingGlass = "magnifyingglass"
        static let plusCircle = "plus.circle"
        static let circle = "circle"
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
