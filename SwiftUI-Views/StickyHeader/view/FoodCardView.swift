//
//  CardView.swift
//  SwiftUI-Views
//
//  Created by jimmy on 2022/3/29.
//

import SwiftUI

struct FoodCardView: View {
    var food: Food
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Text(food.title)
//                    .font(.title2)
                    .fontWeight(.bold)
                
                Text(food.description)
                    .font(.caption)
                    .lineLimit(3)
                
                Text(food.price)
                    .fontWeight(.bold)
                
                Spacer(minLength: 10)
                
                Image(food.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 130, height: 130)
                    .cornerRadius(10)
            }
        }
        .padding(.horizontal)
    }
}

struct FoodCardView_Previews: PreviewProvider {
    static var previews: some View {
        StickyHeaderContentView()
    }
}
