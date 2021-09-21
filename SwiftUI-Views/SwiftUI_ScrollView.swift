//
//  SwiftUI_ScrollView.swift
//  SwiftUI-Views
//
//  Created by jimmy on 2021/9/12.
//

/*
 The SwiftUI framework provides a Group view for developers to group related content. Most importantly, you can attach modifiers to the group to apply the changes to each of the views embedded in the group.
 */

import SwiftUI

struct SwiftUI_ScrollView: View {
    var body: some View {
        VStack(spacing: 0) {
            CardHeaderView()
            CardListView()

            Spacer()
        }
        
    }
}

struct CardListView: View {
    var body: some View {
//        ScrollView {
//            VStack {
//                CardView(image: "swiftui-button", category: "SwiftUI", heading: "Drawing a Border with Rounded Corners", author: "Simon Ng")
//                CardView(image: "macos-programming", category: "macOS", heading: "Building a Simple Editing App", author: "Gabriel Theodoropoulos")
//                CardView(image: "flutter-app", category: "Flutter", heading: "Building a Complex Layout with Flutter", author: "Lawrence Tan")
//                CardView(image: "natural-language-api", category: "iOS", heading: "What's Newin Natural Language API", author: "Sai Kambampati")
//            }
//        }
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                Group {
                    CardView(image: "swiftui-button", category: "SwiftUI", heading: "Drawing a Border with Rounded Corners", author: "Simon Ng")
                    CardView(image: "macos-programming", category: "macOS", heading: "Building a Simple Editing App", author: "Gabriel Theodoropoulos")
                    CardView(image: "flutter-app", category: "Flutter", heading: "Building a Complex Layout with Flutter", author: "Lawrence Tan")
                    CardView(image: "natural-language-api", category: "iOS", heading: "What's Newin Natural Language API", author: "Sai Kambampati")
                }
                .frame(width:300)
            }
        }
    }
}

struct CardView:View {
    var image: String
    var category: String
    var heading: String
    var author: String
    
    var body: some View {
        VStack {
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
            HStack {
                VStack(alignment: .leading) {
                    Text(category)
                        .font(.headline)
                        .foregroundColor(.secondary)
                    Text(heading)
                        .font(.title)
                        .fontWeight(.black)
                        .foregroundColor(.primary)
                        .lineLimit(3)
                    Text("Written by \(author)".uppercased())
                        .font(.caption)
                }
                .minimumScaleFactor(0.5)
                .foregroundColor(.secondary)
                
                Spacer()
            }
            .padding()
        }
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
        )
        .padding([.top, .horizontal])
    }
}

struct CardHeaderView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text("SUNDAY, SEP 12")
                    .font(.system(.caption, design: .rounded))
                    .foregroundColor(.gray)
                Text("Your Reading")
                    .font(.system(.largeTitle, design: .rounded))
                    .fontWeight(.black)
            }
            Spacer()
        }
        .padding([.top,.horizontal])
    }
}

struct SwiftUI_ScrollView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUI_ScrollView()
    }
}
