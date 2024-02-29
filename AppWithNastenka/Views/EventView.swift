import SwiftUI
import State

struct EventView: View {
    var event: Event
    var body: some View {
        HStack(alignment: .bottom) {
            VStack (alignment: .center) {
                Image(systemName: EventView.Images.circleFill)
                    .resizable()
                    .overlay(Circle().stroke(.white, lineWidth: EventView.Dimensions.circleStrokeWidth).padding(-EventView.Dimensions.circleStrokeWidth / 2))
                    .frame(width: EventView.Dimensions.imageSize, height: EventView.Dimensions.imageSize)
                Text(event.username)
                    .lineLimit(1)
                    .multilineTextAlignment(.center)
                    .font(Font.custom(FontNames.jostRegular, size: GlobalConstants.smallFontSize))
                    .frame(width: EventView.Dimensions.imageSize + 25)
            }
            VStack (alignment: .leading) {
                Text(event.name)
                    .font(Font.custom(FontNames.jostRegular, size: GlobalConstants.largeFontSize))
                Text(event.date)
                    .font(Font.custom(FontNames.jostRegular, size: GlobalConstants.smallFontSize))
                HStack {
                    ForEach(event.characteristics, id: \.self) { characteristic in
                        Text(characteristic.name)
                            .frame(width: CGFloat(characteristic.name.count *  EventView.Dimensions.characteristicWidthMultiplier), height: EventView.Dimensions.characteristicFrameHeight)
                            .font(Font.custom(FontNames.jostRegular, size: GlobalConstants.smallFontSize))
                            .padding(.horizontal, EventView.Dimensions.characteristicHorisontalPadding)
                            .lineLimit(1)
                            .foregroundColor(.black)
                            .background(ColorScheme.lemonYellow)
                            .clipShape(RoundedRectangle(cornerRadius:  EventView.Dimensions.characteristicCornerRadius))
                    }
                }
            }
            Spacer()
        }
        .frame(alignment: .leading)
        .padding()
        .background(ColorScheme.darkGray)
        .clipShape(RoundedRectangle(cornerRadius: GlobalConstants.defaultCornerRadius))
    }
}

extension EventView {
    struct Dimensions {
        static let circleStrokeWidth: CGFloat = 2
        static let imageSize: CGFloat =  60
        static let characteristicFrameHeight: CGFloat =  30
        static let characteristicHorisontalPadding: CGFloat =  10
        static let characteristicCornerRadius: CGFloat = 25
        static let characteristicWidthMultiplier: Int = 6
    }
    
    struct Images {
        static let circleFill = "circle.fill"
    }
}


struct EventView_Previews: PreviewProvider {
    static var previews: some View {
        EventView(event: Event(username: "margo", name: "margo", date: "April 11, 2024", characteristics: [Characteristic(name: "90's party", description: "blabla")]))
    }
}
