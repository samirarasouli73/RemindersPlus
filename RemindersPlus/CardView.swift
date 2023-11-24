//
//  CardView.swift
//  RemindersPlus
//
//  Created by Samira Resouliikhechi on 24/11/23.
//

import SwiftUI

struct CardView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var isPresented = false
    var icon: String
    var title: String
    var listCount: Int?
    var lightModeBackgroundColor: Color
    var darkModeBackgroundColor: Color
    var iconColor: Color
    var width: CGFloat

    init(icon: String, title: String, listCount: Int?, lightModeBackgroundColor: Color, darkModeBackgroundColor: Color, iconColor: Color, width: CGFloat) {
        self.icon = icon
        self.title = title
        self.listCount = listCount
        self.lightModeBackgroundColor = lightModeBackgroundColor
        self.darkModeBackgroundColor = darkModeBackgroundColor
        self.iconColor = iconColor
        self.width = width
    }

    var body: some View {
        Button(action: {
            isPresented = true
        }) {
            HStack {
                VStack(alignment: .leading) {
                    Image(systemName: icon)
                        .font(.system(size: 35))
                        .foregroundColor(iconColor)
                        .padding(.horizontal, -5)

                    Text(title)
                        .font(.headline)
                        .foregroundColor(Color(.systemGray))
                        .padding(.vertical, 5)
                        .bold()
                }

                Spacer()

                if let listCount = listCount {
                    Text("\(listCount)")
                        .font(.title)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .padding(.bottom, 30)
                        .foregroundColor(colorScheme == .light ? .black : .white)
                        .bold()
                } else {
                    Spacer()
                }
            }
            .padding()
            .frame(width: width, height: 90)
            .background(colorScheme == .light ? lightModeBackgroundColor : darkModeBackgroundColor)
            .cornerRadius(12)
            .shadow(radius: 0)
        }
        .buttonStyle(PlainButtonStyle())
        .sheet(isPresented: $isPresented) {
                RemindersView()
                    
        }
    }
}
