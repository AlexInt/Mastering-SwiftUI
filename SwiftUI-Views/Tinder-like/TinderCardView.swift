//
//  TinderCardView.swift
//  SwiftUI-Views
//
//  Created by jimmy on 2021/10/7.
//

import SwiftUI

struct TinderCardView: View, Identifiable {
    let id = UUID()
    let image: String
    let title: String
    
    var body: some View {
        Image(image)
            .resizable()
            .scaledToFill()
            .frame(minWidth: 0, maxWidth: .infinity)
            .cornerRadius(10)
            .padding(.horizontal, 15)
            .overlay(
                VStack {
                    Text(title)
                        .font(.system(.headline, design: .rounded))
                        .fontWeight(.bold)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 10)
                        .background(Color.white)
                        .cornerRadius(5)
                }
                    .padding([.bottom], 20)
                , alignment: .bottom)
    }
}

struct TinderCardView_Previews: PreviewProvider {
    static var previews: some View {
        TinderCardView(image: "yosemite-usa", title: "Yosemite, USA")
    }
}
