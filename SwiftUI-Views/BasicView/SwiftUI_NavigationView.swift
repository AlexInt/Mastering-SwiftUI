//
//  SwiftUI_NavigationView.swift
//  SwiftUI-Views
//
//  Created by jimmy on 2021/9/21.
//

//https://developer.apple.com/documentation/uikit/uinavigationbarappearance
/*
 1. StandardAppearance(.standardAppearance)-theappearanceofastandard- height navigation bar (e.g. the navigation bar appeared in iPhone portrait)
 2. CompactAppearance(.compactAppearance)-theappearanceofacompact-height navigation bar (e.g. the navigation bar appeared in iPhone landscape)
 3. ScrollEdgeAppearance(.scrollEdgeAppearance)-thisistheappearancewhen the edge of the scrolled content reaches the navigation bar
 */

import SwiftUI

struct SwiftUI_NavigationView: View {
//    change the title's font and color, no modifier in SwiftUI, use  UINavigationBarAppearance provided by UIKit
    init() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor:UIColor.systemRed,
                                                     .font:UIFont(name: "ArialRoundedMTBold", size: 35)!]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.systemRed,
                                                .font: UIFont(name: "ArialRoundedMTBold", size: 20)!]
        //1. change the indicator image
        navBarAppearance.setBackIndicatorImage(UIImage(systemName: "arrow.turn.up.left"), transitionMaskImage: UIImage(systemName: "arrow.turn.up.left"))
        
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
        
        //2.change the indicator image
        UINavigationBar.appearance().tintColor = .black
    }
    
    @State var restaurants = Restaurants
    @State private var showActionSheet = false
    @State private var selectedRestaurant: Restaurant?
    
    var body: some View {
        NavigationView {
            List {
                ForEach(restaurants) { restaurant in
                    //Passing Data to a Detail View Using NavigationLink
                    // a special button called NavigationLink
                    
                    NavigationLink(destination: RestaurantDetailView(restaurant: restaurant)) {
                        BasicImageRow(restaurant: restaurant)
                            .contextMenu {
                                Button(action: {
                                    self.setCheckIn(item: restaurant)
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
                                    self.setFavorite(item: restaurant)
                                }) {
                                    HStack {
                                        Text("Favorite")
                                        Image(systemName: "star")
                                    }
                                }
                            }
                            .onTapGesture {
                                showActionSheet.toggle()
                                selectedRestaurant = restaurant
                            }
//                            .actionSheet(isPresented: $showActionSheet) {
//                                ActionSheet(title: Text("What do you want to do"),
//                                            message: nil,
//                                            buttons: [
//                                                .default(Text("Mark as Favorite"), action: {
//                                                    if let selectedRestaurant = selectedRestaurant {
//                                                        self.setFavorite(item: selectedRestaurant)
//                                                    }
//                                                }),
//                                                .destructive(Text("Delete"), action: {
//                                                    if let selectedRestaurant = selectedRestaurant {
//                                                        self.delete(item: selectedRestaurant)
//                                                    }
//                                                }),
//                                                .cancel()
//                                            ])
//                            }
                            .actionSheet(item: $selectedRestaurant) { restaurant in
                                ActionSheet(title: Text("What do you want to do"), message: nil, buttons: [
                                    .default(Text("Mark as Favorite"), action: {
                                        self.setFavorite(item: restaurant)
                                    }),
                                    .destructive(Text("Delete"), action: {
                                        self.delete(item: restaurant)
                                    }),
                                    .cancel()
                                ])
                            }
                    }
                }
                .onDelete { indexSet in
                    restaurants.remove(atOffsets: indexSet)
                }
            }
            .navigationBarTitle("Restaurants", displayMode: .large) //.inline
        }
    }
    
    private func delete(item restaurant: Restaurant) {
        if let index = self.restaurants.firstIndex(where: {$0.id == restaurant.id }) {
            self.restaurants.remove(at: index)
        }
    }
    
    private func setFavorite(item restaurant: Restaurant) {
        if let index = self.restaurants.firstIndex(where: {$0.id == restaurant.id }) {
            self.restaurants[index].isFavorite.toggle()
        }
    }
    
    private func setCheckIn(item restaurant: Restaurant) {
        if let index = self.restaurants.firstIndex(where: {$0.id == restaurant.id }) {
            self.restaurants[index].isCheckIn.toggle()
        }
    }
}

struct SwiftUI_NavigationView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUI_NavigationView()
    }
}

struct RestaurantDetailView: View {
    @Environment(\.presentationMode) var mode
    
    var restaurant: Restaurant
    var body: some View {
        VStack {
            Image(restaurant.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text(restaurant.name)
                .font(.system(.title, design: .rounded))
                .fontWeight(.black)
                .padding(.bottom,0)
            Spacer()
        }
        .background(Color.black)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            self.mode.wrappedValue.dismiss()
        }, label: {
//            Text("\(Image(systemName: "chevron.left")) \(restaurant.name)")
            Text("\(Image(systemName: "chevron.left.circle.fill"))")
                .font(.largeTitle)
                .foregroundColor(.white)
        }))
    }
}
