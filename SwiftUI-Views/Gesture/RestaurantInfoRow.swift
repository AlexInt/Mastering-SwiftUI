//
//  RestaurantInfoRow.swift
//  SwiftUI-Views
//
//  Created by jimmy on 2021/10/6.
//

import SwiftUI

struct RestaurantInfoRow: View {
    var restaurant: RestaurantInfo
    
    var body: some View {
        HStack {
            Image(restaurant.image)
                .resizable()
                .frame(width: 40, height: 40)
                .cornerRadius(5)
            Text(restaurant.name)
        }
    }
}

struct RestaurantInfoRow_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantInfoRow(restaurant: restaurantInfos[0])
    }
}
