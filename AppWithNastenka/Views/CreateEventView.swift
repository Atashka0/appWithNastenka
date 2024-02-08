import SwiftUI
import State

enum EventType: Int, CaseIterable {
    case privatized
    case open
    var title: String {
        switch self {
        case .privatized: return "Private"
        case .open: return "Open"
        }
    }
    
    var description: String {
        switch self {
        case .privatized: return "Private events can be seen only by the people you invite."
        case .open: return "Open events can be seen by all users"
        }
    }
}

struct CreateEventView: View {
    @State private var place: String = ""
    @State private var eventName: String = ""
    @State private var eventDescription: String = ""
    @State private var characteristics: [(name: String, description: String)] = [("","")]
    @State private var participants: [User] = []
    @State private var selectedType: EventType = .privatized
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading) {
                    HStack {
                        ForEach(EventType.allCases, id: \.rawValue) { type in
                            ZStack {
                                RoundedRectangle(cornerRadius:  GlobalConstants.defaultCornerRadius)
                                    .fill(selectedType == type ? ColorScheme.lemonYellow : Color.clear)
                                
                                Text(type.title)
                                    .foregroundStyle(selectedType == type ? Color.black : Color.white)
                                    .font(Font.custom(FontNames.jostLight, size: GlobalConstants.smallFontSize))
                            }
                            .onTapGesture {
                                withAnimation(.easeInOut) {
                                    self.selectedType = type
                                }
                            }
                        }
                    }
                    .background(MainView.Colors.darkGray)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .frame(height: 30)
                    
                    Text(selectedType.description)
                        .foregroundStyle(Color(uiColor: .systemGray3))
                        .font(Font.custom(FontNames.jostRegular, size: GlobalConstants.smallFontSize))
                        .frame(maxWidth: .infinity)
                        .frame(alignment: .center)
                    
                    TextField("New event title", text: $place)
                        .modifier(TextFieldModifier())
                    TextField("Place, date and time", text: $eventName)
                        .modifier(TextFieldModifier())
                    TextArea(placeholder: "Description", text: $eventDescription)
                        .frame(height:200)
                    Text("Invited Friends")
                        .foregroundStyle(Color(.systemGray3))
                        .font(Font.custom(FontNames.jostRegular, size: GlobalConstants.smallFontSize))
                    ZStack {
                        Circle().fill(MainView.Colors.darkGray)
                            .frame(width: 60, height: 60)
                        Image(systemName: "plus")
                    }
                    Text("Characteristics")
                        .font(Font.custom(FontNames.jostRegular, size: 20))
                    ForEach(0..<characteristics.count, id: \.self) { index in
                        if (characteristics.last?.description != "" || characteristics.last?.name != "") {
                            ZStack {
                                VStack {
                                    TextField("For example, “Theme”", text: $characteristics[index].name)
                                        .modifier(TextFieldModifier(strokeColor: Color.clear))
                                        .background(Color.black)
                                    TextField("For example, “90’s party”", text: $characteristics[index].description)
                                        .foregroundStyle(Color.black)
                                        .modifier(TextFieldModifier(strokeColor: Color.clear))
                                        .background(Color.black)
                                }
                            }
                            .padding()
                            .background(MainView.Colors.darkGray)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding(.horizontal)
                        } else {
                            VStack {
                                TextField("For example, “Theme”", text: $characteristics[index].name)
                                    .modifier(TextFieldModifier(strokeColor: Color.clear))
                                    .background(Color.black)
                                TextField("For example, “90’s party”", text: $characteristics[index].description)
                                    .foregroundStyle(Color.black)
                                    .modifier(TextFieldModifier(strokeColor: Color.clear))
                                    .background(Color.black)
                            }
                            .padding()
                            .background(MainView.Colors.darkGray)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding(.horizontal)
                        }
                    }
//                    Button(action: {
//                        characteristics.append(("", ""))
//                    }) {
//                        Image(systemName: "plus.circle.fill")
//                            .font(.system(size: 20))
//                            .foregroundColor(ColorScheme.blackAndLemonYellow)
//                    }
//                    .padding(.horizontal)
                }
                Spacer()
                
            }
            VStack {
                Spacer()
                Button(action: {
                    
                }) {
                    Text("Create event")
                        .modifier(ButtonModifier())
                }
            }
        }
        .font(Font.custom(FontNames.jostRegular, size: GlobalConstants.fontSize))
        .padding()
    }
}

struct CreateEventView_Previews: PreviewProvider {
    static var previews: some View {
        CreateEventView()
    }
}
