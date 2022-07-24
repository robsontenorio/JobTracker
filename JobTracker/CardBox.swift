//
//  CardBox.swift
//  JobTracker
//
//  Created by Robson Tenório on 22/07/22.
//

import SwiftUI

struct CardBox<Content: View>: View {
    let content: Content
    let background: Color
    let color: Color
    let border: Color
    let icon: String
    var caption: String

    init(background: Color? = .clear, color: Color? = .white, border: Color? = .clear, icon: String, caption: String, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.background = background!
        self.color = color!
        self.border = border!
        self.icon = icon
        self.caption = caption
    }

    var body: some View {
        VStack(alignment: .center) {
            Image(systemName: icon)
                .foregroundColor(color)
                .padding(.bottom, 1)
                .font(.caption)

            self.content
                .foregroundColor(color)

            Text(caption)
                .font(.caption)
                .foregroundColor(color)
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .strokeBorder(border)
                .background(RoundedRectangle(cornerRadius: 10).fill(background))
        )
    }
}

struct CardBox_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CardBox(background: .blue, icon: "calendar", caption: "May") {
                Text("43")
                    .font(.title2)
                    .bold()
            }

            CardBox(background: .orange, icon: "clock", caption: "hours") {
                Text("43")
                    .font(.title2)
                    .bold()
            }

            CardBox(color: .green, border: .green, icon: "dollarsign", caption: "earns") {
                Text("311.100,00")
                    .font(.title2)
                    .bold()
            }
        }
    }
}
