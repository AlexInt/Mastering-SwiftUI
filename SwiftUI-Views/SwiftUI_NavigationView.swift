//
//  SwiftUI_NavigationView.swift
//  SwiftUI-Views
//
//  Created by jimmy on 2021/9/21.
//

import SwiftUI

struct SwiftUI_NavigationView: View {
    var body: some View {
        NavigationView {
            List {
                ForEach(restaurants) { restaurant in
                    NavigationLink(destination: RestaurantDetailView(restaurant: restaurant)) {
                        BasicImageRow(restaurant: restaurant)
                    }
                }
            }
            .navigationBarTitle("Restaurants", displayMode: .inline)
        }
    }
}

struct SwiftUI_NavigationView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUI_NavigationView()
    }
}

struct RestaurantDetailView: View {
    var restaurant: Restaurant
    var body: some View {
        VStack {
            Image(restaurant.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text(restaurant.name)
                .font(.system(.title, design: .rounded))
                .fontWeight(.black)
            Spacer()
        }
    }
}
