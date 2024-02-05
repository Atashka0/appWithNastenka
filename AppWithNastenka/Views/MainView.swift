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
                ForEach(MainViewType.allCases, id: \.rawValue) {
                    item in
                        Text(item.title)
                            .background(selectedView == item ? Color.init(red: 18/256, green: 18/256, blue: 18/256) : Color.black)
                            .frame(width: 30, height: 25)
                            .clipShape(RoundedRectangle(cornerRadius: 13))
                            .onTapGesture {
                                withAnimation(.easeInOut) {
                                    self.selectedView = item
                                }
                            }
                }
                Spacer()
                Image(systemName: "magnifyingglass")
                Text("Invites")
            }
            ScrollView {
                VStack {
                    EventView(username: "margo_april", eventName: "Halloween costume party", date: "October 31, 2023", characteristics: ["90's party", "90's inspired", "Best costume contest"])
                    Spacer()
                    EventView(username: "valeria_syropyatova", eventName: "Margo’s BD", date: "April 11, 2024", characteristics: ["90's party", "90's inspired", "Best costume contest"])
                }
            }
            Spacer()
            HStack {
                Image(systemName: "plus.circle")
                Spacer()
                Image(systemName: "circle")
            }
        }
        .padding()
        .font(Font.custom(FontNames.jostRegular, size: GlobalConstants.textSize))
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
