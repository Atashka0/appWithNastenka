import SwiftUI
import State
import ReSwift

struct CreateEventView: View {
    @ObservedObject var eventController: EventController
    
    @State private var event: Event = Event(characteristics: [Characteristic()])
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {
                    HStack {
                        ForEach(EventType.allCases, id: \.rawValue) { type in
                            ZStack {
                                RoundedRectangle(cornerRadius:  GlobalConstants.defaultCornerRadius)
                                    .fill(event.type == type ? ColorScheme.lemonYellow : Color.clear)
                                
                                Text(type.title)
                                    .foregroundStyle(event.type == type ? Color.black : Color.white)
                                    .font(Font.custom(FontNames.jostLight, size: GlobalConstants.smallFontSize))
                            }
                            .onTapGesture {
                                withAnimation(.easeInOut) {
                                    self.event.type = type
                                }
                            }
                        }
                    }
                    .background(ColorScheme.darkGray)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .frame(height: 30)
                    
                    Text(event.type.description)
                        .foregroundStyle(Color(uiColor: .systemGray3))
                        .font(Font.custom(FontNames.jostRegular, size: GlobalConstants.smallFontSize))
                        .frame(maxWidth: .infinity)
                        .frame(alignment: .center)
                    
                    TextField("New event title", text: $event.name)
                        .modifier(TextFieldModifier(strokeColor: ColorScheme.darkGray))
                    TextField("Place, date and time", text: $event.place)
                        .modifier(TextFieldModifier(strokeColor: ColorScheme.darkGray))
                    TextArea(placeholder: "Description", text: $event.description)
                        .frame(height:200)
                    Text("Invited Friends")
                        .foregroundStyle(Color(.systemGray3))
                        .font(Font.custom(FontNames.jostRegular, size: GlobalConstants.smallFontSize))
                    ZStack {
                        Circle().fill(ColorScheme.darkGray)
                            .frame(width: 60, height: 60)
                        Image(systemName: "plus")
                    }
                    Text("Characteristics")
                        .font(Font.custom(FontNames.jostRegular, size: 20))
                    ForEach(0..<event.characteristics.count, id: \.self) { index in
                        ZStack {
                            VStack {
                                TextField("For example, “Theme”", text: $event.characteristics[index].name)
                                    .modifier(TextFieldModifier(strokeColor: .clear))
                                    .background(Color.black)
                                    .onChange(of: event.characteristics[index].name) { newValue in
                                        if index == event.characteristics.count -  1 && !newValue.isEmpty {
                                            event.characteristics.append(Characteristic())
                                        }
                                    }
                                TextArea(placeholder: "For example, “90’s party”", text: $event.characteristics[index].description)
                                    .background(Color.black)
                                    .onChange(of: event.characteristics[index].description) { newValue in
                                        if index == event.characteristics.count -  1 && !newValue.isEmpty {
                                            event.characteristics.append(Characteristic())
                                        }
                                    }
                                    .frame(height: 90)
                            }
                            .padding()
                            .background(ColorScheme.darkGray)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding(.horizontal)
                            if (event.characteristics[index].description != "" || event.characteristics[index].name != "") {
                                ZStack {
                                    Circle()
                                        .fill(ColorScheme.darkGray)
                                        .frame(width: 20, height: 20)
                                    Image("closeCross")
                                        .resizable()
                                        .frame(width: 8, height: 8)
                                }
                                .zIndex(1)
                                .foregroundStyle(.white)
                                .offset(x: 170, y: -85)
                                .onTapGesture {
                                    event.characteristics.remove(at: index)
                                }
                            }
                        }
                    }
                    .padding(.horizontal, -16)
                }
                Spacer(minLength:  60)
                
            }
            VStack {
                Spacer()
                Button(action: {
                    event.characteristics.removeLast()
                    stateStore.dispatch(EventAction.createEvent(event))
                    stateStore.dispatch(NavigationAction.setSheet(nil))
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
        CreateEventView(eventController: EventController())
    }
}
