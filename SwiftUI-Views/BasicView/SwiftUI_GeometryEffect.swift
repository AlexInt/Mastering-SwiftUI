//
//  SwiftUI_GeometryEffect.swift
//  SwiftUI-Views
//
//  Created by jimmy on 2021/11/28.
//

import SwiftUI

struct SwiftUI_GeometryEffect: View {
    
    @State private var expand = false
    
    @Namespace private var shapeTransition
    
    var body: some View {
        //        Circle()
        //            .fill(Color.green)
        //            .frame(width: expand ? 300 : 150, height: expand ? 300 : 150)
        //            .offset(y: expand ? -200 : 0)
        //            .animation(.default)
        //            .onTapGesture {
        //                self.expand.toggle()
        //            }
        
        /*
         With the matchedGeometryEffect modifier, you no longer need to figure out these differences. All you need to do is describe two views: one represents the start state and the other is for the final state. matchedGeometryEffect will automatically interpolate the size and position between the views.
         */
        /*
         For both Circle views, we attach the matchedGeometryEffect modifier and specify the same ID & namespace. By doing so, SwiftUI computes the size & position difference between these two views and interpolates the transition. Along with the animation modifier, the framework will automatically animate the transition.
         
         The ID and namespace are used for identifying which views are part of the same transition. This is why both Circle views use the same ID and namespace.
         */
        //        if expand {
        //            // Final State
        //            Circle()
        //                .fill(Color.green)
        //                .matchedGeometryEffect(id: "circle", in: shapeTransition)
        //                .frame(width: 300, height: 300)
        //                .offset(y: -200)
        //                .animation(.default)
        //                .onTapGesture {
        //                    self.expand.toggle()
        //                }
        //        } else {
        //
        //            // Start State
        //            Circle()
        //                .fill(Color.green)
        //                .matchedGeometryEffect(id: "circle", in: shapeTransition)
        //                .frame(width: 150, height: 150)
        //                .offset(y: 0)
        //                .animation(.default)
        //                .onTapGesture {
        //                    self.expand.toggle()
        //                }
        //        }
        
        //        AnimationDemoView(expand: $expand)
        
//        SwapView(swap: $expand)
        
        ArticleDetailTransition()
        
    }
    
}

struct SwiftUI_GeometryEffect_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUI_GeometryEffect()
    }
}


struct AnimationDemoView: View {
    @Namespace private var shapeTransition
    @Binding var expand: Bool
    
    var body: some View {
        VStack {
            if expand {
                // Rounded Rectangle
                Spacer()
                RoundedRectangle(cornerRadius: 50.0)
                    .matchedGeometryEffect(id: "circle", in: shapeTransition)
                    .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 300)
                    .padding()
                    .foregroundColor(Color(.systemGreen))
                    .animation(.easeIn)
                    .onTapGesture {
                        expand.toggle()
                    }
            } else {
                // Circle
                RoundedRectangle(cornerRadius: 50.0)
                    .matchedGeometryEffect(id: "circle", in: shapeTransition)
                    .frame(width: 100, height: 100)
                    .foregroundColor(Color(.systemOrange))
                    .animation(.easeIn)
                    .onTapGesture {
                        expand.toggle()
                    }
                Spacer()
            }
        }
    }
}

struct SwapView: View {
    @Binding var swap:Bool
    @Namespace private var dotTransition
    
    var body: some View {
        if swap {
            // After swap
            // Green dot on the left, Orange dot on the right
            HStack {
                
                Circle()
                    .fill(Color.green)
                    .frame(width: 100, height: 100)
                    .matchedGeometryEffect(id: "greenCircle", in: dotTransition)
                Spacer()
                
                Circle()
                    .fill(Color.orange)
                    .frame(width: 100, height: 100)
                    .matchedGeometryEffect(id: "orangeCircle", in: dotTransition)
            }
            .frame(width: 250)
            .animation(.linear)
            .onTapGesture {
                swap.toggle()
            }
        } else {
            // Start state
            // Orange dot on the left, Green dot on the right
            HStack {
                Circle()
                    .fill(Color.orange)
                    .frame(width: 100, height: 100)
                    .matchedGeometryEffect(id: "orangeCircle", in: dotTransition)
                
                Spacer()
                
                Circle()
                    .fill(Color.green)
                    .frame(width: 100, height: 100)
                    .matchedGeometryEffect(id: "greenCircle", in: dotTransition)
            }
            .frame(width: 250)
            .animation(.linear)
            .onTapGesture {
                swap.toggle()
            }
            
        }
    }
}

struct ArticleTransition: View {
    @Binding var showDetail: Bool
    var articleTransition: Namespace.ID
    
    var body: some View {
        // Display an article view with smaller image
        if !showDetail {
            VStack {
                
                Spacer()
                
                VStack {
                    Image("coffee-15")
                        .resizable()
                        .scaledToFill()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 200)
                        .matchedGeometryEffect(id: "image", in: articleTransition)
                        .cornerRadius(10)
                        .animation(.interactiveSpring())
                        .padding()
                        .onTapGesture {
                            showDetail.toggle()
                        }
                    
                    Text("The Watertower is a full-service restaurant/cafe located in the Sweet Auburn District of Atlanta.")
                        .matchedGeometryEffect(id: "text", in: articleTransition)
                        .animation(nil)
                        .padding(.horizontal)
                }
                
            }
        }
        
        // Display the article view in a full screen
        if showDetail {
            ScrollView {
                VStack {
                    Image("coffee-15")
                        .resizable()
                        .scaledToFill()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 400)
                        .clipped()
                        .matchedGeometryEffect(id: "image", in: articleTransition)
                        .animation(.interactiveSpring())
                        .onTapGesture {
                            showDetail.toggle()
                        }
                    
                    Text("The Watertower is a full-service restaurant/cafe located in the Sweet Auburn District of Atlanta. The restaurant features a full menu of moderatel y priced \"comfort\" food influenced by African and French cooking traditions, but based upon time honored recipes from around the world. The cafe section of The Wa tertower features a coffeehouse with a dessert bar, magazines, and space for live performers.\n\nThe Watertower will be owned and operated by The Watertower LLC, a Georgia limited liability corporation managed by David N. Patton IV, a resident of the Empowerment Zone. The members of the LLC are David N. Patton IV (80%) and the Historic District Development Corporation (20%).\n\nThis business plan offers fin ancial institutions an opportunity to review our vision and strategic focus. It al so provides a step-by-step plan for the business start-up, establishing favorable sales numbers, gross margin, and profitability.\n\nThis plan includes chapters on the company, products and services, market focus, action plans and forecasts, mana gement team, and financial plan.")
                        .matchedGeometryEffect(id: "text", in: articleTransition)
                        .animation(.easeOut)
                        .padding(.all, 20)
                    
                    Spacer()
                    
                }
            }
            .edgesIgnoringSafeArea(.all)
        }
        
    }
}


struct ArticleDetailTransition: View {
    @State private var showDetail = false
    @Namespace private var articleTransition
    
    var body: some View {
        // Display an article view with smaller image
        if !showDetail {
            ArticleTransition(showDetail: $showDetail,
                              articleTransition: articleTransition)
        }
        
        // Display the article view in a full screen
        if showDetail {
            ArticleTransition(showDetail: $showDetail,
                              articleTransition: articleTransition)
        }
    }
}
