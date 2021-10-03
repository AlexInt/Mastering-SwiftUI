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
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(restaurants) { restaurant in
                    //Passing Data to a Detail View Using NavigationLink
                    // a special button called NavigationLink
                    
                    NavigationLink(destination: RestaurantDetailView(restaurant: restaurant)) {
                        BasicImageRow(restaurant: restaurant)
                    }
                }
            }
            .navigationBarTitle("Restaurants", displayMode: .large) //.inline
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
