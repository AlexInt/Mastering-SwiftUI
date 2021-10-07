//
//  Tinder.swift
//  SwiftUI-Views
//
//  Created by jimmy on 2021/10/7.
//

import SwiftUI

struct Tinder: View {
    
   @State var cardViews:[TinderCardView] = {
        (0..<2).map{ TinderCardView(image: trips[$0].image, title: trips[$0].destination) }
    }()
    
    @GestureState private var dragState = DragState.inactive
    
    private let dragThreshold: CGFloat = 80.0
    //keep track of the last index of the trip. Say, when the card deck is first initialized, we display the first two trips stored in the trips array. The last index is set to 1 .
    @State private var lastIndex = 1
    @State private var removalTransition = AnyTransition.trailingBottom
    
    var body: some View {
        VStack {
            TopBarMenu()
            
            ZStack {
                ForEach(cardViews) { cardView in
                    cardView
                        .zIndex(self.isTopCard(cardView: cardView) ? 1 : 0)
                        .overlay(
                            ZStack {
                                Image(systemName: "x.circle")
                                    .foregroundColor(.white)
                                    .font(.system(size: 100))
                                    .opacity(dragState.translation.width < -dragThreshold && self.isTopCard(cardView: cardView) ? 1.0 : 0.0)
                                
                                Image(systemName: "heart.circle")
                                    .foregroundColor(.red)
                                    .font(.system(size: 100))
                                    .opacity(dragState.translation.width > dragThreshold && self.isTopCard(cardView: cardView) ? 1.0 : 0.0)
                            }
                        )
                        .offset(x: self.isTopCard(cardView: cardView) ? dragState.translation.width : 0, y: self.isTopCard(cardView: cardView) ? dragState.translation.height : 0)
                        .scaleEffect(dragState.isDragging && self.isTopCard(cardView: cardView) ? 0.95 : 1.0)
                        .rotationEffect(Angle(degrees: self.isTopCard(cardView: cardView) ? Double(dragState.translation.width/10) : 0))
                        .animation(.interpolatingSpring(stiffness: 180, damping: 100))
                        .transition(self.removalTransition)
                        .gesture(
                            LongPressGesture(minimumDuration: 0.01)
                                .sequenced(before: DragGesture())
                                .updating($dragState, body: { value, state, transaction in
                                    switch value {
                                    case .first(true):
                                        state = .pressing
                                    case .second(true, let drag):
                                        state = .dragging(translation: drag?.translation ?? .zero)
                                    default:
                                        break
                                    }
                                })
                                .onChanged({ value in
                                    guard case .second(true, let drag?) = value else {
                                        return
                                    }
                                    if drag.translation.width < -self.dragThreshold {
                                        self.removalTransition = .leadingBottom
                                    }
                                    if drag.translation.width > self.dragThreshold {
                                        self.removalTransition = .trailingBottom
                                    }
                                })
                                .onEnded({ value in
                                    guard case .second(true, let drag?) = value else {
                                        return
                                    }
                                    if drag.translation.width < -self.dragThreshold ||
                                        drag.translation.width > self.dragThreshold {
                                        self.moveCard()
                                    }
                                })
                        )
                }
            }
            
            Spacer(minLength: 20)
            
            BottomBarMenu()
                .opacity(dragState.isDragging ? 0.0 : 1.0)
                .animation(.default)
        }
    }
    
    private func isTopCard(cardView: TinderCardView) -> Bool {
        guard let index = cardViews.firstIndex(where: {$0.id == cardView.id}) else {
            return false
        }
        return index == 0
    }
    
    private func moveCard() {
        cardViews.removeFirst()
        self.lastIndex += 1
        let trip = trips[lastIndex % trips.count]
        //After the last photo of the trips array is displayed, the app will revert back to the first element (note the modulus operator % in the code above).
        let newCardView = TinderCardView(image: trip.image, title: trip.destination)
        cardViews.append(newCardView)
    }
}

struct Tinder_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Tinder()
//            TopBarMenu().previewLayout(.fixed(width: 375, height: 60))
//            BottomBarMenu().previewLayout(.fixed(width: 375, height: 60))
        }
    }
}

struct TopBarMenu:View {
    var body: some View {
        HStack {
            Image(systemName: "line.horizontal.3")
                .font(.system(size: 30))
            
            Spacer()
            
            Image(systemName: "mappin.and.ellipse")
                .font(.system(size: 35))
            
            Spacer()
            
            Image(systemName: "heart.circle.fill")
                .font(.system(size: 30))
            
        }
    }
}

struct BottomBarMenu: View {
    var body: some View {
        HStack {
            Image(systemName: "xmark")
                .font(.system(size: 30))
                .foregroundColor(.black)
            
            Button(action: {
                
            }) {
                Text("BOOK IT NOW")
                    .font(.system(.subheadline, design: .rounded))
                    .bold()
                    .foregroundColor(.white)
                    .padding(.horizontal, 35)
                    .padding(.vertical, 15)
                    .background(Color.black)
                    .cornerRadius(10)
            }
            .padding(.horizontal, 20)
            
            Image(systemName: "heart")
                .font(.system(size: 30))
                .foregroundColor(.black)
        }
    }
}

extension AnyTransition {
    //is used when the card view is thrown away to the right of the screen
    static var trailingBottom: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .identity,
            removal: AnyTransition.move(edge: .trailing).combined(with: .move(edge: .bottom))
        )
    }
    
    //when the card view is thrown away to the left.
    static var leadingBottom: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .identity,
            removal: AnyTransition.move(edge: .leading).combined(with: .move(edge: .bottom))
        )
    }
}
