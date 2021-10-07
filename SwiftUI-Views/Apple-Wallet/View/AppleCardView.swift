//
//  AppleCardView.swift
//  SwiftUI-Views
//
//  Created by jimmy on 2021/10/7.
//

import SwiftUI

struct AppleCardView: View {
    var card: Card
    
    var body: some View {
        Image(card.image)
            .resizable()
            .scaledToFit()
            .overlay(
                VStack(alignment: .leading) {
                    Text(card.number)
                        .bold()
                    HStack {
                        Text(card.name)
                            .bold()
                        Text("Valid Thru")
                            .font(.footnote)
                        Text(card.expiryDate)
                            .font(.footnote)
                    }
                }
                    .foregroundColor(.white)
                    .padding(.leading, 25)
                    .padding(.bottom, 20)
                , alignment: .bottomLeading)
            .shadow(color: .gray, radius: 1.0, x: 0.0, y: 1.0)
    }
}

struct AppleCardView_Previews: PreviewProvider {
    static var previews: some View {
        
        AppleCardView(card: testCards[1])
            .padding(.horizontal, 5)
    }
}
