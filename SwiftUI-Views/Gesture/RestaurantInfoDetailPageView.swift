//
//  RestaurantInfoDetailPageView.swift
//  SwiftUI-Views
//
//  Created by jimmy on 2021/10/6.
//

import SwiftUI

enum ViewState {
    case full
    case half
}

struct RestaurantInfoDetailPageView: View {
    let restaurant: RestaurantInfo
    
    @GestureState private var dragState = DragState.inactive
    @State private var positionOffset: CGFloat = 0.0
    
    @State private var viewState = ViewState.half
    
    @Binding var isShow: Bool
    
    // keep track of the scroll offset
    @State private var scrollOffset: CGFloat = 0.0
    
    
    var body: some View {
        //        GeometryReader that gives you access to the size and position of the parent view
        GeometryReader { geometry in
            VStack {
                Spacer()
                
                HandleBar()
                
                ScrollView(.vertical, showsIndicators: true) {
                    GeometryReader { scrollViewProxy in
//                        Text("\(scrollViewProxy.frame(in: .named("scrollView")).minY)")
                        
                        //we retrieve the scroll offset and save it into the preference key. We use the Color.clear view to make the view invisible to the users.
                        Color.clear.preference(key: ScrollOffsetKey.self, value: scrollViewProxy.frame(in: .named("scrollview")).minY)
                    }
                    .frame(height: 0)
                    
                    VStack {
                        TitleBar()
                        
                        RestaurantInfoHeaderView(restaurant: self.restaurant)
                        RestaurantInfoDetailView(icon: "icon", info: restaurant.location)
                        RestaurantInfoDetailView(icon: "phone", info: restaurant.phone)
                        RestaurantInfoDetailView(icon: nil, info: restaurant.description)
                            .padding(.top)
                            .padding(.bottom, 100)
                    }
//                    .offset(y:-scrollOffset)
                    .animation(nil)
                }
                .background(Color.white)
                .cornerRadius(10,antialiased: true)
                .disabled(viewState == .half) //solve gesture conflicts
                //disable the user interaction of the scroll view when the detail view is in half opened state.
                .coordinateSpace(name: "scrollview")
            }
            .offset(y:geometry.size.height/2 + dragState.translation.height + positionOffset)
            .offset(y:self.scrollOffset)
            .animation(.interpolatingSpring(stiffness: 200.0, damping: 25.0, initialVelocity: 10.0))
            .edgesIgnoringSafeArea(.all)
            //etrieve the scroll offset from the preference
            .onPreferenceChange(ScrollOffsetKey.self) { value in
//                print("\(value)")
                if self.viewState == .full {
                    self.scrollOffset = value > 0 ? value : 0
                    
                    if self.scrollOffset > 120 {
                        self.positionOffset = 0
                        self.viewState = .half
                        self.scrollOffset = 0
                    }
                }
            }
            .gesture(
                DragGesture()
                    .updating($dragState, body: { value, state, transaction in
                        state = .dragging(translation: value.translation)
                    })
                    .onEnded({ value in
                        
                        if viewState == .half {
                            // Threshold #1 (highest point)
                            // Slide up and when it goes beyond the threshold
                            // change the view state to fully opened by updating
                            // the position offset
                            if value.translation.height < -geometry.size.height * 0.25 {
                                self.positionOffset = -geometry.size.height/2 + 50
                                self.viewState = .full
                            }
                            // Threshold #2 (lowest point)
                            // Slide down and when it goes pass the threshold
                            // dismiss the view by setting isShow to false
                            if value.translation.height > geometry.size.height * 0.3 {
                                self.isShow = false
                            }
                        }
                        
                    })
            )
        }
    }
}

struct RestaurantInfoDetailPageView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantInfoDetailPageView(restaurant: restaurantInfos[0], isShow: .constant(true))
            .background(Color.black.opacity(0.3))
            .edgesIgnoringSafeArea(.all)
    }
}

struct HandleBar: View {
    var body: some View {
        Rectangle()
            .frame(width: 50, height: 5)
            .foregroundColor(Color(.systemGray5))
            .cornerRadius(10)
    }
}

struct TitleBar: View {
    var body: some View {
        HStack {
            Text("Restaurant Details")
                .font(.headline)
                .foregroundColor(.primary)
            
            Spacer()
        }
        .padding()
    }
}

struct RestaurantInfoHeaderView:View {
    var restaurant: RestaurantInfo
    
    var body: some View {
        Image(restaurant.image)
            .resizable()
            .scaledToFill()
            .frame(height: 300)
            .clipped()
            .overlay(
                HStack {
                    VStack(alignment: .leading) {
                        Spacer()
                        
                        Text(restaurant.name)
                            .foregroundColor(.white)
                            .font(.system(.largeTitle,design: .rounded))
                            .bold()
                        
                        Text(restaurant.type)
                            .font(.system(.headline, design: .rounded))
                            .padding(5)
                            .foregroundColor(.white)
                            .background(Color.red)
                            .cornerRadius(5)
                    }
                    Spacer()
                }
                    .padding()
            )
    }
}

struct RestaurantInfoDetailView:View {
    let icon: String?
    let info: String
    
    var body: some View {
        HStack {
            if icon != nil {
                Image(systemName: icon!)
                    .padding(.trailing,10)
            }
            Text(info)
                .font(.system(.body, design: .rounded))
            
            Spacer()
        }
        .padding(.horizontal)
    }
}

// PreferenceKey which allows you to easily pass data from child views to its ancestors.
struct ScrollOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    
    static var defaultValue: CGFloat = .zero
    
    //implement the reduce function to combine the offset values into one.
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}
