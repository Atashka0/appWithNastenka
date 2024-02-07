import SwiftUI

struct EventView: View {
    var event: Event
    var body: some View {
            HStack {
                VStack (alignment: .center) {
                    Image(systemName: EventView.Images.circleFill)
                        .resizable()
                        .frame(width: EventView.Dimensions.imageSize, height: EventView.Dimensions.imageSize)
                    Text(event.username)
                        .lineLimit(1)
                        .multilineTextAlignment(.center)
                        .font(Font.custom(FontNames.jostRegular, size: GlobalConstants.smallFontSize))
                }
                .frame(width:  EventView.Dimensions.userDataFrame, height:  EventView.Dimensions.userDataFrame)
                Spacer(minLength:  EventView.Dimensions.spacerLength)
                VStack (alignment: .leading) {
                    Text(event.name)
                        .font(Font.custom(FontNames.jostRegular, size: GlobalConstants.largeFontSize))
                    Text(event.date)
                        .font(Font.custom(FontNames.jostRegular, size: GlobalConstants.smallFontSize))
                    Spacer(minLength: 10)
                    HStack {
                        ForEach(event.characteristics, id: \.self) { characteristic in
                            Text(characteristic)
                                .frame(width: CGFloat(characteristic.count *  EventView.Dimensions.characteristicWidthMultiplier), height: EventView.Dimensions.characteristicFrameHeight)
                                .font(Font.custom(FontNames.jostRegular, size: GlobalConstants.smallFontSize))
                                .lineLimit(1)
                                .foregroundColor(.black)
                                .background(ColorScheme.lemonYellow)
                                .clipShape(RoundedRectangle(cornerRadius:  EventView.Dimensions.characteristicCornerRadius))
                        }
                    }
                }
            }
            .frame(width: EventView.Dimensions.frameWidth, height: EventView.Dimensions.frameHeight)
            .padding()
            .background(EventView.Colors.darkGray)
            .clipShape(RoundedRectangle(cornerRadius: GlobalConstants.defaultCornerRadius))
        }}

extension EventView {
    struct Colors {
        static let darkGray = Color(red:  18/256, green:  18/256, blue:  18/256)
    }
    
    struct Dimensions {
        static let frameWidth: CGFloat  = 355
        static let imageSize: CGFloat =  60
        static let frameHeight: CGFloat =  80
        static let characteristicFrameHeight: CGFloat =  30
        static let spacerLength: CGFloat = 5
        static let userDataFrame: CGFloat = 100
        static let characteristicCornerRadius: CGFloat = 25
        static let characteristicWidthMultiplier: Int = 6
    }
    
    struct Images {
        static let circleFill = "circle.fill"
        static let backgroundColor = Color(red:  18/256, green:  18/256, blue:  18/256)
    }
}


struct EventView_Previews: PreviewProvider {
    static var previews: some View {
        EventView(event: Event(username: "margo", name: "Halloween costume party", date: "April 11, 2024", characteristics: ["90's party", "90's inspired", "Best costume contest"]))

    }
}
