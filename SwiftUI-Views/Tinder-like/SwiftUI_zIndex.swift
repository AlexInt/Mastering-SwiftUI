//
//  SwiftUI_zIndex.swift
//  SwiftUI-Views
//
//  Created by jimmy on 2021/10/7.
// https://www.hackingwithswift.com/quick-start/swiftui/how-to-change-the-order-of-view-layering-using-z-index

import SwiftUI

/*
 By default, SwiftUI’s ZStack layers its views using the painter’s algorithm to decide depth of views: whatever you put into the ZStack first is drawn first, then subsequent views are layered over it.
 
 While this is often what you want, sometimes you need more control – you might want to push one view behind another while your app runs, for example, or perhaps bring one particular view to the front when it’s tapped.

 To do this you need to use the zIndex() modifier, which allows you to specify exactly how views should be layered inside a single ZStack. Views have a default Z index of 0, but you can provide positive or negative values that position them on top of or below other views respectively.

 For example, this ZStack contains two overlapping rectangles, but the green rectangle will still be visible because it uses a Z index value of 1:
 */

struct SwiftUI_zIndex: View {
    
    @State private var isFront = false
    
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(Color.green)
                    .frame(width: 50, height: 50)
                    .zIndex(isFront ? 1 : 0) //default value is 0

                Rectangle()
                    .fill(Color.red)
                    .frame(width: 100, height: 100)
            }
            
            Toggle("bring green to the front", isOn: $isFront)
                .foregroundColor(.green)
                .padding(.horizontal, 15)
        }
    }
}

struct SwiftUI_zIndex_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUI_zIndex()
    }
}
