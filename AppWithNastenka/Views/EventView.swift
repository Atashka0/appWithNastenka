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
                    Image(systemName: "circle")
                        .resizable()
                        .frame(width: 60, height: 60)
                    Text(username)
                        .lineLimit(1)
                        .multilineTextAlignment(.center)
                        .font(Font.custom(FontNames.jostRegular, size: 12))
                }
                Spacer(minLength: 5)
                VStack (alignment: .leading) {
                    Text(eventName)
                        .font(Font.custom(FontNames.jostRegular, size: 20))
                    Text(date)
                        .font(Font.custom(FontNames.jostRegular, size: 12))
                    Spacer()
                    HStack {
                        ForEach(characteristics, id: \.self) { characteristic in
                            Text(characteristic)
                                .frame(width: CGFloat(characteristic.count * 6), height: 30)
                                .font(Font.custom(FontNames.jostRegular, size: 12))
                                .lineLimit(1)
                                .foregroundColor(.black)
                                .background(ColorScheme.lemonYellow)
                                .clipShape(RoundedRectangle(cornerRadius: 25))
                        }
                    }
                }
            }
            .frame(height: 80)
            .padding()
            .background(Color.init(red: 18/256, green: 18/256, blue: 18/256))
            .clipShape(RoundedRectangle(cornerRadius: 13))
        }
}

struct EventView_Previews: PreviewProvider {
    static var previews: some View {
        EventView(username: "margo", eventName: "Margo’s BD", date: "April 11, 2024", characteristics: ["90's party", "90's inspired", "Best costume contest"])

    }
}
