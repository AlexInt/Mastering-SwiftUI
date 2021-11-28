//
//  LazyGrid.swift
//  SwiftUI-Views
//
//  Created by jimmy on 2021/11/28.
//

import SwiftUI
/*
 the space between rows is controlled by the spacing parameter of LazyVGrid
 */
struct LazyGridContentView: View {
    private var symbols = ["keyboard", "hifispeaker.fill", "printer.fill", "tv.fill", "desktopcomputer", "headphones", "tv.music.note", "mic", "plus.bubble", "video"]
    
    private var colors: [Color] = [.yellow, .purple, .green]

    //The spacing between grid items is controlled by the instances of GridItem initialized in gridItemLayout
//    private var gridItemLayout = [GridItem(.flexible(), spacing: 10),
//                                  GridItem(.flexible(), spacing: 20),
//                                  GridItem(.flexible(), spacing: 20)]
    
    //If you want to place as many items as possible in a row
//    private var gridItemLayout = [GridItem(.adaptive(minimum: 50))]
    
    //you can also use .fixed if you want to create fixed width columns
//    private var gridItemLayout = [GridItem(.fixed(100)), GridItem(.fixed(150))]
    
    //You are allowed to mix different size types to create more complex grid layout
    private var gridItemLayout = [GridItem(.fixed(150)),
                                  GridItem(.adaptive(minimum: 50))]
    
    var body: some View {
//        ScrollView {
//            //the space between rows is controlled by the spacing parameter of LazyVGrid
//            LazyVGrid(columns: gridItemLayout, spacing: 20) {
//                ForEach((0...9999), id:\.self) {
//                    Image(systemName: symbols[$0 % symbols.count])
//                        .font(.system(size: 30))
//                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 50)
//                        .background(colors[$0 % colors.count])
//                        .cornerRadius(10)
//                }
//            }
//        }
        
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: gridItemLayout, spacing: 20) {
                ForEach((0...9999), id:\.self) {
                    Image(systemName: symbols[$0 % symbols.count])
                        .font(.system(size: 30))
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 50, maxHeight: .infinity)
                        .background(colors[$0 % colors.count])
                        .cornerRadius(10)
                }
            }
        }
        
        
    }
}

struct LazyGrid_Previews: PreviewProvider {
    static var previews: some View {
        LazyGridContentView()
    }
}



