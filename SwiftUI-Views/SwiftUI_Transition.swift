//
//  SwiftUI_Transition.swift
//  SwiftUI-Views
//
//  Created by jimmy on 2021/9/21.
//

import SwiftUI

struct SwiftUI_Transition: View {
    
    @State private var show = false
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 300, height: 300)
                .foregroundColor(.green)
                .overlay(
                    Text("Show details")
                        .font(.system(.largeTitle, design: .rounded))
                        .bold()
                        .foregroundColor(.white)
                )
            
            if show {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 300, height: 300)
                    .foregroundColor(.purple)
                    .overlay(
                        Text("Well, here is the details")
                            .font(.system(.largeTitle, design: .rounded))
                            .bold()
                            .foregroundColor(.white)
                    )
//                    .transition(.scale(scale: 0, anchor: .bottom)) //smaller middle botton
//                    .transition(.offset(x: -600, y: 0)) //slides in from the left
                
//                    .transition(.offset(x: -600, y: 0).combined(with: .scale))
//                    .transition(.offset(x: -600, y: 0).combined(with: .scale).combined(with: .opacity))
//                    .transition(.offsetScaleOpacity)
                    .transition(.scaleAndOffset)
            }
        }
        .onTapGesture {
            withAnimation(.spring()) {
                self.show.toggle()
            }
        }
        
    }
}

//custom a reusable animation
extension AnyTransition {
    //symmetric, meaning that the insertion and removal of the view use the same transition
    static var offsetScaleOpacity: AnyTransition {
        AnyTransition.offset(x: -600, y: 0)
            .combined(with: .scale)
            .combined(with: .opacity)
    }
    
    static var scaleAndOffset: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .scale(scale: 0, anchor: .bottom),
            removal: .offset(x: -600, y: 00)
        )
    }
}

struct SwiftUI_Transition_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUI_Transition()
    }
}
