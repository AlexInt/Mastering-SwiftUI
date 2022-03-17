//
//  NeumorphismLight.swift
//  SwiftUI-Views
//
//  Created by jimmy on 2022/3/17.
//

import SwiftUI


extension Color {
    static let OffWhite1 = Color(red: 225/255.0, green: 225/255.0, blue: 235/255.0)
}

extension LinearGradient {
    init(_ colors: Color...) {
        self.init(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}

struct SimpleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(30)
            .contentShape(Circle())
            .background(
                Group {
                    if configuration.isPressed {
                        Circle()
                            .fill(Color.OffWhite1)
                            .overlay(
                                Circle()
                                    .stroke(Color.gray,lineWidth: 4)
                                    .blur(radius: 4)
                                    .offset(x: 2, y: 2)
                                    .mask(Circle().fill(LinearGradient(Color.black, Color.clear)))
                            )
                            .overlay(
                                Circle()
                                    .stroke(Color.white,lineWidth: 8)
                                    .blur(radius: 4)
                                    .offset(x: -2, y: -2) //value in reverse
                                    .mask(Circle().fill(LinearGradient(Color.clear, Color.black)))
                            )
                    } else {
                        Circle()
                            .fill(Color.OffWhite1)
                            .shadow(color: .black.opacity(0.2), radius: 10, x: 10, y: 10)
                            .shadow(color: .white.opacity(0.7), radius: 10, x: -5, y: -5)
                    }
                }
            )
    }
}
struct NeumorphismLight: View {
    var body: some View {
        ZStack {
            Color.OffWhite1
            //            RoundedRectangle(cornerRadius: 25)
            //                .fill(Color.OffWhite)
            //                .frame(width: 300, height: 300)
            //                .shadow(color: .black.opacity(0.2), radius: 10, x: 10, y: 10)
            //                .shadow(color: .white.opacity(0.7), radius: 10, x: -5, y: -5)
            Button(action: {
                print("Button tapped")
            }, label: {
                Image(systemName: "heart.fill")
                    .font(.largeTitle)
                    .foregroundColor(.red)
            })
            .buttonStyle(SimpleButtonStyle())
        }
        .edgesIgnoringSafeArea(.all)
    }
}

//struct NeumorphismLight_Previews: PreviewProvider {
//    static var previews: some View {
//        NeumorphismLight()
//    }
//}
