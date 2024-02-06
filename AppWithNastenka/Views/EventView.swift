//
//  EventView.swift
//  AppWithNastenka
//
//  Created by Ilyas Kudaibergenov on 05.02.2024.
//
import SwiftUI
import Foundation

struct EventView: View {
    var username: String
    var eventName: String
    var date: String
    var characteristics: [String] = []
    var body: some View {
            HStack {
                VStack (alignment: .center) {
                    Image(systemName: EventView.Images.circleFill)
                        .resizable()
                        .frame(width: EventView.Dimensions.imageSize, height: EventView.Dimensions.imageSize)
                    Text(username)
                        .lineLimit(1)
                        .multilineTextAlignment(.center)
                        .font(Font.custom(EventView.Fonts.jostRegular, size: EventView.Fonts.regularFontSize))
                }
                .frame(width:  100, height:  100)
                Spacer(minLength:  5)
                VStack (alignment: .leading) {
                    Text(eventName)
                        .font(Font.custom(EventView.Fonts.jostRegular, size: EventView.Fonts.largeFontSize))
                    Text(date)
                        .font(Font.custom(EventView.Fonts.jostRegular, size: EventView.Fonts.regularFontSize))
                    Spacer()
                    HStack {
                        ForEach(characteristics, id: \.self) { characteristic in
                            Text(characteristic)
                                .frame(width: CGFloat(characteristic.count *  6), height: EventView.Dimensions.characteristicFrameHeight)
                                .font(Font.custom(EventView.Fonts.jostRegular, size: EventView.Fonts.regularFontSize))
                                .lineLimit(1)
                                .foregroundColor(.black)
                                .background(ColorScheme.lemonYellow)
                                .clipShape(RoundedRectangle(cornerRadius:  25))
                        }
                    }
                }
            }
            .frame(height: EventView.Dimensions.frameHeight)
            .padding()
            .background(EventView.Colors.darkGray)
            .clipShape(RoundedRectangle(cornerRadius: EventView.Dimensions.cornerRadius))
        }}

extension EventView {
    struct Colors {
        static let darkGray = Color(red:  18/256, green:  18/256, blue:  18/256)
    }
    
    struct Dimensions {
        static let imageSize: CGFloat =  60
        static let frameHeight: CGFloat =  80
        static let cornerRadius: CGFloat =  13
        static let characteristicFrameHeight: CGFloat =  30
    }
    
    struct Fonts {
        static let jostRegular = "Jost-Regular"
        static let regularFontSize: CGFloat =  12
        static let largeFontSize: CGFloat =  20
    }
    
    struct Images {
        static let circleFill = "circle.fill"
        static let backgroundColor = Color(red:  18/256, green:  18/256, blue:  18/256)
    }
}


struct EventView_Previews: PreviewProvider {
    static var previews: some View {
        EventView(username: "margo", eventName: "Halloween costume party", date: "April 11, 2024", characteristics: ["90's party", "90's inspired", "Best costume contest"])

    }
}
