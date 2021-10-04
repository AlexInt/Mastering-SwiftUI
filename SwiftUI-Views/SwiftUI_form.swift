//
//  SwiftUI_form.swift
//  SwiftUI-Views
//
//  Created by jimmy on 2021/10/4.
//

import SwiftUI

struct SwiftUI_form: View {
    @State var restaurantItems = [
        RestaurantItem(name: "Cafe Deadend", type: "Coffee & Tea Shop", phone: "232-923423", image: "cafedeadend", priceLevel: 3),
        RestaurantItem(name: "Homei", type: "Cafe", phone: "348-233423", image: "homei", priceLevel: 3),
        RestaurantItem(name: "Teakha", type: "Tea House", phone: "354-243523", image: "teakha", priceLevel: 3, isFavorite: true, isCheckIn: true),
        RestaurantItem(name: "Cafe loisl", type: "Austrian / Casual Drink", phone: "453-333423", image: "cafeloisl", priceLevel: 2, isFavorite: true, isCheckIn: true),
        RestaurantItem(name: "Petite Oyster", type: "French", phone: "983-284334", image: "petiteoyster", priceLevel: 5, isCheckIn: true),
        RestaurantItem(name: "For Kee Restaurant", type: "Hong Kong", phone: "232-434222", image: "forkeerestaurant", priceLevel: 2, isFavorite: true, isCheckIn: true),
        RestaurantItem(name: "Po's Atelier", type: "Bakery", phone: "234-834322", image: "posatelier", priceLevel: 4),
        RestaurantItem(name: "Bourke Street Backery", type: "Chocolate", phone: "982-434343", image: "bourkestreetbakery", priceLevel: 4, isCheckIn: true),
        RestaurantItem(name: "Haigh's Chocolate", type: "Cafe", phone: "734-232323", image: "haighschocolate", priceLevel: 3, isFavorite: true),
        RestaurantItem(name: "Palomino Espresso", type: "American / Seafood", phone: "872-734343", image: "palominoespresso", priceLevel: 2),
        RestaurantItem(name: "Upstate", type: "Seafood", phone: "343-233221", image: "upstate", priceLevel: 4),
        RestaurantItem(name: "Traif", type: "American", phone: "985-723623", image: "traif", priceLevel: 5),
        RestaurantItem(name: "Graham Avenue Meats", type: "Breakfast & Brunch", phone: "455-232345", image: "grahamavenuemeats", priceLevel: 3),
        RestaurantItem(name: "Waffle & Wolf", type: "Coffee & Tea", phone: "434-232322", image: "wafflewolf", priceLevel: 3),
        RestaurantItem(name: "Five Leaves", type: "Bistro", phone: "343-234553", image: "fiveleaves", priceLevel: 4, isFavorite: true, isCheckIn: true),
        RestaurantItem(name: "Cafe Lore", type: "Latin American", phone: "342-455433", image: "cafelore", priceLevel: 2, isFavorite: true, isCheckIn: true),
        RestaurantItem(name: "Confessional", type: "Spanish", phone: "643-332323", image: "confessional", priceLevel: 4),
        RestaurantItem(name: "Barrafina", type: "Spanish", phone: "542-343434", image: "barrafina", priceLevel: 2, isCheckIn: true),
        RestaurantItem(name: "Donostia", type: "Spanish", phone: "722-232323", image: "donostia", priceLevel: 1),
        RestaurantItem(name: "Royal Oak", type: "British", phone: "343-988834", image: "royaloak", priceLevel: 2, isFavorite: true),
        RestaurantItem(name: "CASK Pub and Kitchen", type: "Thai", phone: "432-344050", image: "caskpubkitchen", priceLevel: 1)
    ]
    
    
    @State private var selectedRestaurant: RestaurantItem?
    @State private var showSettings: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(restaurantItems) { restaurant in
                    RestaurantBasicImageRow(restaurant: restaurant)
                        .contextMenu {
                            
                            Button(action: {
                                // mark the selected restaurant as check-in
                                self.checkIn(item: restaurant)
                            }) {
                                HStack {
                                    Text("Check-in")
                                    Image(systemName: "checkmark.seal.fill")
                                }
                            }
                            
                            Button(action: {
                                // delete the selected restaurant
                                self.delete(item: restaurant)
                            }) {
                                HStack {
                                    Text("Delete")
                                    Image(systemName: "trash")
                                }
                            }
                            
                            Button(action: {
                                // mark the selected restaurant as favorite
                                self.setFavorite(item: restaurant)
                                
                            }) {
                                HStack {
                                    Text("Favorite")
                                    Image(systemName: "star")
                                }
                            }
                        }
                        .onTapGesture {
                            self.selectedRestaurant = restaurant
                        }
                }
                .onDelete { (indexSet) in
                    self.restaurantItems.remove(atOffsets: indexSet)
                }
            }
            .navigationBarTitle("Restaurant")
            .navigationBarItems(trailing:
                                    
            Button(action: {
                self.showSettings = true
            }, label: {
                Image(systemName: "gear")
                    .font(.title3)
                    .foregroundColor(.black)
            })
            )
            .sheet(isPresented: $showSettings) {
                SettingView()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        
        
    }
    
    private func delete(item restaurant: RestaurantItem) {
        if let index = self.restaurantItems.firstIndex(where: { $0.id == restaurant.id }) {
            self.restaurantItems.remove(at: index)
        }
    }
    
    private func setFavorite(item restaurant: RestaurantItem) {
        if let index = self.restaurantItems.firstIndex(where: { $0.id == restaurant.id }) {
            self.restaurantItems[index].isFavorite.toggle()
        }
    }
    
    private func checkIn(item restaurant: RestaurantItem) {
        if let index = self.restaurantItems.firstIndex(where: { $0.id == restaurant.id }) {
            self.restaurantItems[index].isCheckIn.toggle()
        }
    }
}

struct RestaurantItem: Identifiable {
    var id = UUID()
    var name: String
    var type: String
    var phone: String
    var image: String
    var priceLevel: Int
    var isFavorite: Bool = false
    var isCheckIn: Bool = false
}

struct RestaurantBasicImageRow: View {
    var restaurant: RestaurantItem
    
    var body: some View {
        
        HStack {
            Image(restaurant.image)
                .resizable()
                .frame(width: 60, height: 60)
                .clipShape(Circle())
                .padding(.trailing, 10)
            
            VStack(alignment: .leading) {
                HStack {
                    Text(restaurant.name)
                        .font(.system(.body, design: .rounded))
                        .bold()
                    
                    Text(String(repeating: "$", count: restaurant.priceLevel))
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                }
                
                Text(restaurant.type)
                    .font(.system(.subheadline, design: .rounded))
                    .bold()
                    .foregroundColor(.secondary)
                    .lineLimit(3)
                
                Text(restaurant.phone)
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundColor(.secondary)
            }
            
            Spacer()
                .layoutPriority(-100)
            
            if restaurant.isCheckIn {
                Image(systemName: "checkmark.seal.fill")
                    .foregroundColor(.red)
            }
            
            if restaurant.isFavorite {
                //                    Spacer()
                
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
            }
        }
        
        
    }
}


struct SwiftUI_form_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUI_form()
    }
}
