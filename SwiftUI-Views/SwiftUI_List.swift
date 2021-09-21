//
//  SwiftUI_List.swift
//  SwiftUI-Views
//
//  Created by jimmy on 2021/9/21.
//

import SwiftUI

struct SwiftUI_List: View {
    var body: some View {
//        List {
//            ForEach(1...4, id:\.self) {
//                Text("Item \($0)")
//            }
//        }
        List(restaurants.indices) {index in
            if (0...1).contains(index) {
                FullImageRow(restaurant: restaurants[index])
            } else {
                BasicImageRow(restaurant: restaurants[index])
            }
        }
    }
}

struct Restaurant: Identifiable {
    var id = UUID()
    var name: String
    var image: String
}

var restaurants = [
    Restaurant(name: "Cafe Deadend", image: "cafedeadend"),
    Restaurant(name: "Homei", image: "homei"),
    Restaurant(name: "Teakha", image: "teakha"),
    Restaurant(name: "Cafe Loisl", image: "cafeloisl"),
    Restaurant(name: "Petite Oyster", image: "petiteoyster"),
    Restaurant(name: "For Kee Restaurant", image: "forkeerestaurant"),
    Restaurant(name: "Po's Atelier", image: "posatelier"),
    Restaurant(name: "Bourke Street Bakery", image: "bourkestreetbakery"),
    Restaurant(name: "Haigh's Chocolate", image: "haighschocolate"),
    Restaurant(name: "Palomino Espresso", image: "palominoespresso"),
    Restaurant(name: "Upstate", image: "upstate"),
    Restaurant(name: "Traif", image: "traif"),
    Restaurant(name: "Graham Avenue Meats And Deli", image: "grahamavenuemeats"),
    Restaurant(name: "Waffle & Wolf", image: "wafflewolf"),
    Restaurant(name: "Five Leaves", image: "fiveleaves"),
    Restaurant(name: "Cafe Lore", image: "cafelore"),
    Restaurant(name: "Confessional", image: "confessional"),
    Restaurant(name: "Barrafina", image: "barrafina"),
    Restaurant(name: "Donostia", image: "donostia"),
    Restaurant(name: "Royal Oak", image: "royaloak"),
    Restaurant(name: "CASK Pub and Kitchen", image: "caskpubkitchen")]

struct SwiftUI_List_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUI_List()
    }
}

struct BasicImageRow: View {
    
    var restaurant: Restaurant
    
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

struct FullImageRow: View {
    var restaurant: Restaurant
    var body: some View {
        ZStack {
            Image(restaurant.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 200)
                .cornerRadius(10)
                .overlay(
                    Rectangle()
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        .opacity(0.2)
                )
            
            Text(restaurant.name)
                .font(.system(.title, design: .rounded))
                .fontWeight(.black)
                .foregroundColor(.white)
        }
    }
}
