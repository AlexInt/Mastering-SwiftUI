//
//  ImageCarouselContentView.swift
//  SwiftUI-Views
//
//  Created by jimmy on 2021/11/21.
//

import SwiftUI

struct ImageCarouselContentView: View {
    
    @State private var isCardTapped = false
    @State private var currentTripIndex = 2
    @GestureState private var dragOffset: CGFloat = 0
    
    var body: some View {
        ZStack {
            //Title
            VStack(alignment: .leading) {
                Text("Discover")
                    .font(.system(.largeTitle, design: .rounded))
                    .fontWeight(.black)
                Text("Explore your next destination")
                    .font(.system(.headline, design: .rounded))
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
            .padding(.top, 25)
            .padding(.leading, 20)
            .opacity(self.isCardTapped ? 0.1 : 1.0)
            .offset(y: self.isCardTapped ? -100 : 0)
            
            //Carousel
            GeometryReader { outerView in
                HStack(spacing: 0.0) {
                    ForEach(sampleICTrips.indices) { index in
                        GeometryReader { innerView in
                            ICTripCardView(destination: sampleICTrips[index].destination,
                                           imageName: sampleICTrips[index].image,
                                           isShowDetails: self.$isCardTapped)
                                .offset(y: self.isCardTapped ? -innerView.size.height * 0.3 : 0)
                        }
                        .padding(.horizontal, self.isCardTapped ? 0 : 20)
                        .opacity(self.currentTripIndex == index ? 1.0 : 0.7)
                        .frame(width: outerView.size.width,
                               height: self.currentTripIndex == index ? (self.isCardTapped ? outerView.size.height : 450) : 400)
                        .onTapGesture {
                            self.isCardTapped = true
                        }
                            
                    }
                }
                .frame(width: outerView.size.width, height: outerView.size.height, alignment: .leading)
                .offset(x: -CGFloat(self.currentTripIndex) * outerView.size.width)
                .offset(x: self.dragOffset)
                .gesture(
                    !self.isCardTapped ?
                    
                    DragGesture()
                        .updating(self.$dragOffset, body: {(value, state, transaction) in
                            state = value.translation.width
                        })
                        .onEnded({value in
                            let threshold = outerView.size.width * 0.5
                            var newIndex = Int(-value.translation.width / threshold) + self.currentTripIndex
                            newIndex = min(max(newIndex, 0), sampleICTrips.count - 1)
                            self.currentTripIndex = newIndex
                        })
                    
                    : nil
                )
            }
            .animation(.interpolatingSpring(mass: 0.4, stiffness: 100, damping: 10, initialVelocity: 0.3))
            
            
            if self.isCardTapped {
                ICTripDetailView(destination: sampleICTrips[currentTripIndex].destination)
                    .offset(y: 200)
                    .transition(.move(edge: .bottom))
                    .animation(.interpolatingSpring(mass: 0.5, stiffness: 100, damping: 10, initialVelocity: 0.3))
                Button(action: {
                    self.isCardTapped = false
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 30))
                        .foregroundColor(.black)
                        .opacity(0.7)
                        .contentShape(Rectangle())
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topTrailing)
                .padding(.trailing)
            }
        }
        
    }
}

struct ImageCarouselContentView_Previews: PreviewProvider {
    static var previews: some View {
        ImageCarouselContentView()
    }
}
