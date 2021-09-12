//
//  SwiftUI_Text.swift
//  SwiftUI-Views
//
//  Created by jimmy on 2021/9/12.
//

import SwiftUI

struct SwiftUI_Text: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20.0) {
                MultilineText()
                TextFontDesign()
                //can also use the design canvas to edit them: control+option
                Text("System size 25 bold rounded")
                    .font(.system(size: 25, weight: .bold, design: .rounded))
                    .foregroundColor(.green)
                UsingCustomFonts()
                
                
                Spacer()
            }
            .padding(.leading, 15)
        }
    }
}

struct TextFontDesign: View {
    var body: some View {
        Group{
            Text("system Title bold design default")
                .fontWeight(.bold)
                .font(.title2)//.system(.title,design: .default)
            Text("system Title bold design rounded")
                .font(.system(.title2, design: .rounded))
                .fontWeight(.bold)
            Text("system Title bold design serif")
                .font(.system(.title2, design: .serif))
                .fontWeight(.bold)
            Text("system Title bold design monospaced")
                .font(.system(.title2, design: .monospaced))
                .fontWeight(.bold)
        }
    }
}

struct UsingCustomFonts: View {
    var body: some View {
        Group {
            Text("custom Fira Code size 30")
                .font(.custom("Fira Code", size: 30)) //find from Font Book.app
                .foregroundColor(.orange)
            Text("custom antre size 30")
                .font(.custom("antre", size: 30)) //find from Font Book.app
                .foregroundColor(.orange)
            Text("春风又绿江南岸 Songti SC")
                .font(.custom("Songti SC", size: 30)) //find from Font Book.app
                .foregroundColor(.orange)
            Text("春风又绿江南岸 Songti TC")
                .font(.custom("Songti TC", size: 30)) //find from Font Book.app
                .foregroundColor(.orange)
        }
    }
}

struct MultilineText: View {
    var body: some View {
        VStack {
            Text("Your time is limited, so don’t waste it living someone else’s life. Don’t be trapped by dogma—which is living with the results of other people’s thinking. Don ’t let the noise of others’ opinions drown out your own inner voice. And most important, have the courage to follow your heart and intuition.")
                .fontWeight(.bold)
                .font(.title)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .lineLimit(nil)  //default value is nil, no limit
                .truncationMode(.head)
                .lineSpacing(15)  //10
                .padding()         //left right space
//                .rotationEffect(.degrees(45)) //default is center
//                .rotationEffect(.degrees(20), anchor: UnitPoint(x: 0, y: 0)) //anchor point top-left corner
                .rotation3DEffect(
                    .degrees(60),
                    axis: (x: 1.0, y: 0.0, z: 0.0)
                ) //effect looks like Star Wars film
                .shadow(color: .gray.opacity(0.35), radius: 2, x: 0, y: 15)
        }
    }
}




struct SwiftUI_Text_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUI_Text()
    }
}
