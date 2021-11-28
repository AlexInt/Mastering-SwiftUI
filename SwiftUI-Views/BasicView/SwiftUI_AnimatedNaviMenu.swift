//
//  SwiftUI_AnimatedNaviMenu.swift
//  SwiftUI-Views
//
//  Created by jimmy on 2021/10/27.
//

import SwiftUI

struct SwiftUI_AnimatedNaviMenu: View {
    @State private var selectedIndex = 0
    var menuItems =  ["Travel", "Film", "Food & Drink"]
    
    var body: some View {
        TabView(selection: $selectedIndex) {
            ForEach(menuItems.indices) { index in
                Text(menuItems[index])
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    .foregroundColor(.white)
                    .font(.system(size: 50, weight: .heavy, design: .rounded))
                    .tag(index)
            }
        }
        .background(Color.green)
        .ignoresSafeArea()
        .tabViewStyle(.page(indexDisplayMode: .never))
        .overlay(
            VStack {
                Spacer()
                
                NavigationMenu(selectedIndex: $selectedIndex, menuItems: menuItems)
                    .padding(.horizontal, 5)
            }
        )
    }
}

struct SwiftUI_AnimatedNaviMenu_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUI_AnimatedNaviMenu()
    }
}

struct NavigationMenu:View {
    @Namespace private var menuItemTransition
    @Binding var selectedIndex:Int
    var menuItems:[String] = []
    

    var body: some View {
        HStack {
            ForEach(menuItems.indices) { index in
                if index == selectedIndex {
                    Text(menuItems[index])
                        .padding(.horizontal)
                        .padding(.vertical, 4)
                        .background(Capsule().foregroundColor(.purple))
                        .foregroundColor(.white)
                        .matchedGeometryEffect(id: "menuItem", in: menuItemTransition)
                } else {
                    Text(menuItems[index])
                        .padding(.horizontal)
                        .padding(.vertical, 4)
                        .background(Capsule().foregroundColor(Color(white: 0.9)))
                        .onTapGesture {
                            selectedIndex = index
                        }
                }
                
                Spacer()
                
            }
        }
        .frame(minWidth:0, maxWidth: .infinity)
        .padding()
        .animation(.easeInOut, value: selectedIndex)
        
    }
}
