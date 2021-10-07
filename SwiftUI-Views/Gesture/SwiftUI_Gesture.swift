//
//  SwiftUI_Gesture.swift
//  SwiftUI-Views
//
//  Created by jimmy on 2021/10/6.
//

import SwiftUI

struct SwiftUI_Gesture: View {
    
    //for tap gesture
    @State private var isPressed = false
    
    //for long press gesture
//    @GestureState private var longPressTap = false
    
    //for drag gesture
//    @GestureState private var dragOffset = CGSize.zero
    @State private var position = CGSize.zero
    @GestureState private var dragSate = DragState.inactive
    
    var body: some View {
        Image(systemName: "star.circle.fill")
            .font(.system(size: 200))
//            .opacity(longPressTap ? 0.5 : 1.0)
            .opacity(dragSate.isPressing ? 0.5 : 1.0)
//            .scaleEffect(isPressed ? 0.5 : 1.0)
//            .offset(x:position.width + dragOffset.width,y: position.height + dragOffset.height)
            .offset(x:position.width + dragSate.translation.width,y: position.height + dragSate.translation.height)
            .animation(.easeInOut)
            .foregroundColor(.green)
            .gesture(
//                TapGesture()
//                    .onEnded({
//                        self.isPressed.toggle()
//                    })
                
                /*
                 The value parameter is the current state of the gesture. This value varies from gesture to gesture, but for the long press gesture, a true value indicates that a tap is detected.
                 The state parameter is actually an in-out parameter that lets you update the value of the longPressTap property. In the code above, we set the value of state to
                 currentState . In other words, the longPressTap property always keeps track of the latest state of the long press gesture.
                 The transaction parameter stores the context of the current state-processing update.
                 */
//                LongPressGesture(minimumDuration: 1.0)
//                    .updating($longPressTap, body: { currentState, state, transaction in
//                        state = currentState
//                    })
//                    .onEnded({ _ in
//                        self.isPressed.toggle()
//                    })
                
//                DragGesture()
//                //the value parameter stores the current data of the drag including the translation
//                    .updating($dragOffset, body: { value, state, transaction in
//                        state = value.translation
//                    })
//                    .onEnded({ value in
//                        position.height += value.translation.height
//                        position.width += value.translation.width
//                    })
                
                
                //Combining Gestures
                /*
                 SwiftUI allows you to easily combine gestures to perform more complex interactions. It provides three gesture composition types including *simultaneous, sequenced, and exclusive*.
                 When you need to detect multiple gestures at the same time, you use the simultaneous composition type. And, when you combine gestures exclusively, SwiftUI recognizes all the gestures you specify but it will ignore the rest when one of the gestures is detected.
                 As the name suggests, if you combine multiple gestures using the sequenced composition type, SwiftUI recognizes the gestures in a specific order. This is exactly the type of the composition that we will use to sequence the long press and drag gestures.

                 */
                LongPressGesture(minimumDuration: 1.0)
//                    .updating($longPressTap, body: { currentState, state, transaction in
//                        state = currentState
//                    })
                //The sequenced keyword is how we can link the long press and drag gestures together. We tell SwiftUI that the LongPressGesture should happen before the DragGesture .
                    .sequenced(before: DragGesture())
//                    .updating($dragOffset, body: { value, state, transaction in
                    .updating($dragSate, body: { value, state, transaction in
                        switch value {
                        case .first(true):
                            state = .pressing
                        case .second(true, let drag):
//                            state = drag?.translation ?? .zero
                            state = .dragging(translation: drag?.translation ?? .zero)
                        default:
                            break
                        }
                    })
                    .onEnded({ value in
                        guard case .second(true, let drag?) = value else {
                            return
                        }
                        position.height += drag.translation.height
                        position.width += drag.translation.width
                    })
            )
    }
}

struct SwiftUI_Gesture_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUI_Gesture()
    }
}
