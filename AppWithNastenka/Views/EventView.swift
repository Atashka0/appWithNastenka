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
                VStack {
                    Image(systemName: "circle")
                        .resizable()
                        .frame(width: 75, height: 75)
                    Text(username)
                        .lineLimit(1)
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
            .padding()
            .background(Color.init(red: 18/256, green: 18/256, blue: 18/256))
            .clipShape(RoundedRectangle(cornerRadius: 13))
        }
}
