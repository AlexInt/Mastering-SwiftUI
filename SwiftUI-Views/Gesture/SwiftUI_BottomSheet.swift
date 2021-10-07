//
//  SwiftUI_BottomSheet.swift
//  SwiftUI-Views
//
//  Created by jimmy on 2021/10/6.
//

import SwiftUI

struct SwiftUI_BottomSheet: View {
    @State private var showDetail = false
    @State private var selectedRestaurant: RestaurantInfo?
    
    var body: some View {
        ZStack {
            NavigationView {
                List {
                    ForEach(restaurantInfos) { restaurant in
                        RestaurantInfoRow(restaurant: restaurant)
                            .onTapGesture {
                                self.showDetail = true
                                self.selectedRestaurant = restaurant
                            }
                    }
                }
                
                .navigationBarTitle("Restaurants")
            }
            .offset(y:showDetail ? -100 : 0)
            .animation(.easeOut(duration: 0.2))
            .navigationViewStyle(StackNavigationViewStyle())
            
            if showDetail {
                BlankView(bgColor: .black)
                    .opacity(0.5)
                    .onTapGesture {
                        self.showDetail = false
                    }
                
                // if let operator is only supported in iOS 14 (or up).
                if let selectedRestaurant = selectedRestaurant {
                    RestaurantInfoDetailPageView(restaurant: selectedRestaurant, isShow: $showDetail)
                        .transition(.move(edge: .bottom))
                }
            }
        }
    }
}

struct SwiftUI_BottomSheet_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUI_BottomSheet()
    }
}

struct BlankView :View {
    var bgColor: Color
    
    var body: some View {
        VStack {
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .background(bgColor)
        .edgesIgnoringSafeArea(.all)
    }
}
