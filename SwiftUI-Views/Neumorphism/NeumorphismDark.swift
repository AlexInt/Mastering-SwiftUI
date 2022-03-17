//
//  NeumorphismDark.swift
//  SwiftUI-Views
//
//  Created by jimmy on 2022/3/17.
//

import SwiftUI

extension Color {
    static let darkStart = Color(red: 50/255.0, green: 60/255.0, blue: 65/255.0)
    static let darkEnd = Color(red: 25/255.0, green: 25/255.0, blue: 30/255.0)
    
    static let lightStart = Color(red: 60/255.0, green: 160/255.0, blue: 240/255.0)
    static let lightEnd = Color(red: 30/255.0, green: 80/255.0, blue: 120/255.0)
}

struct DarkBackground<S: Shape>: View {
    var isHighlighted:Bool
    var shape: S
    
    var body: some View {
        ZStack {
            if isHighlighted {
                shape
                    .fill(LinearGradient(Color.darkEnd,Color.darkStart))
                    .overlay(
                        Circle()
                            .stroke(Color.darkStart,lineWidth: 4)
                            .blur(radius: 4)
                            .offset(x: 2, y: 2)
                            .mask(Circle().fill(LinearGradient(Color.darkEnd, Color.clear)))
                    )
                    .overlay(
                        Circle()
                            .stroke(Color.darkStart,lineWidth: 8)
                            .blur(radius: 4)
                            .offset(x: -2, y: -2) //value in reverse
                            .mask(Circle().fill(LinearGradient(Color.clear, Color.darkEnd)))
                    )
            } else {
                shape
                    .fill(LinearGradient(Color.darkStart,Color.darkEnd))
                    .shadow(color: .darkStart, radius: 10, x: -5, y: -5)
                    .shadow(color: .darkEnd, radius: 10, x: 10, y: 10)
            }
        }
    }
}

struct ColorfulBackground<S: Shape>: View {
    var isHighlighted:Bool
    var shape: S
    
    var body: some View {
        ZStack {
            if isHighlighted {
                shape
                    .fill(LinearGradient(Color.lightEnd,Color.lightStart))
                    .overlay(shape.stroke(LinearGradient(Color.lightStart,Color.lightEnd),lineWidth: 4))
                    .shadow(color: .darkStart, radius: 10, x: 5, y: 5)
                    .shadow(color: .darkEnd, radius: 10, x: -5, y: -5)
            } else {
                shape
                    .fill(LinearGradient(Color.darkStart,Color.darkEnd))
                    .overlay(shape.stroke(LinearGradient(Color.lightStart,Color.lightEnd),lineWidth: 4))
                    .shadow(color: .darkStart, radius: 10, x: -10, y: -10)
                    .shadow(color: .darkEnd, radius: 10, x: 10, y: 10)
            }
        }
    }
}

struct DarkToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
        }, label: {
            configuration.label
                .padding(30)
                .contentShape(Circle())
        })
        .background(
            DarkBackground(isHighlighted: configuration.isOn, shape: Circle())
        )
    }
}

struct DarkButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(30)
            .contentShape(Circle())
            .background(
                DarkBackground(isHighlighted: configuration.isPressed, shape: Circle())
            )
    }
}

struct ColorfulToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
        }, label: {
            configuration.label
                .padding(30)
                .contentShape(Circle())
        })
        .background(
            ColorfulBackground(isHighlighted: configuration.isOn, shape: Circle())
        )
    }
}

struct ColorfulButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(30)
            .contentShape(Circle())
            .background(
                ColorfulBackground(isHighlighted: configuration.isPressed, shape: Circle())
            )
    }
}

struct NeumorphismDark: View {
    @State private var isToggled = false
    
    
    var body: some View {
        ZStack {
            LinearGradient(Color.darkStart,Color.darkEnd)
            HStack(spacing: 50.0) {
                VStack(spacing: 40.0) {
                    Button(action: {
                        print("Button tapped")
                    }, label: {
                        Image(systemName: "heart.fill")
                            .font(.largeTitle)
                            .foregroundColor(.red)
                    })
                    .buttonStyle(DarkButtonStyle())
                    
                    Toggle(isOn: $isToggled, label: {
                        Image(systemName: "heart.fill")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    })
                    .toggleStyle(DarkToggleStyle())
                }
                
                VStack(spacing: 40.0) {
                    Button(action: {
                        print("Button tapped")
                    }, label: {
                        Image(systemName: "heart.fill")
                            .font(.largeTitle)
                            .foregroundColor(.red)
                    })
                    .buttonStyle(ColorfulButtonStyle())
                    
                    Toggle(isOn: $isToggled, label: {
                        Image(systemName: "heart.fill")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    })
                    .toggleStyle(ColorfulToggleStyle())
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct NeumorphismDark_Previews: PreviewProvider {
    static var previews: some View {
        NeumorphismDark()
    }
}
