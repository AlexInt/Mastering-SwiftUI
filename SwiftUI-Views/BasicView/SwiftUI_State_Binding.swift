//
//  SwiftUI_State_Binding.swift
//  SwiftUI-Views
//
//  Created by jimmy on 2021/9/15.
//

import SwiftUI

struct SwiftUI_State_Binding: View {
    @State private var isPlaying = false
    
    @State private var redCounter = 0
    @State private var greenCounter = 0
    @State private var blueCounter = 0
    
    var body: some View {
        VStack {
            Button(action: {
                self.isPlaying.toggle()
            }, label: {
                Image(systemName: isPlaying ? "stop.circle.fill" : "play.circle.fill")
                    .font(.system(size: 150))
                    .foregroundColor(isPlaying ? .red : .green)
            })
            
            
            Spacer()
            
            
            Text("\(redCounter + greenCounter + blueCounter)")
                .font(.system(size: 200, weight: .bold, design: .rounded))
                .foregroundColor(.black)
            
            
            HStack(spacing: 10.0) {
                CounterButton(counter: $redCounter, color: .red)
                CounterButton(counter: $greenCounter, color: .green)
                CounterButton(counter: $blueCounter, color: .blue)
            }
        }
    }
}

struct SwiftUI_State_Binding_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUI_State_Binding()
    }
}

struct CounterButton: View {
    @Binding var counter: Int
    var color: Color
    
    var body: some View {
        Button(action: {
            self.counter += 1
        }, label: {
            //                Text("\(count)")
            //                    .frame(width: 150, height: 150)
            //                    .font(.system(size: 80))
            //                    .foregroundColor(.white)
            //                    .background(Color.red)
            //                    .cornerRadius(100)
            Circle()
                .frame(width: 100, height: 100)
                .foregroundColor(color)
                .shadow(color: .gray, radius: 10, x: 5, y: 10)
                .overlay(
                    Text("\(counter)")
                        .font(.system(size: 50, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                )
            
        })
    }
}
