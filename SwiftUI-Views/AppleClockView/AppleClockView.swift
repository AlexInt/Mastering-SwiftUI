//
//  AppleClockView.swift
//  SwiftUI-Views
//
//  Created by jimmy on 2022/3/7.
//

import SwiftUI

struct NumberView: View {
    var text: String
    var angle: Angle
    var body: some View {
        GeometryReader { proxy in
            let width = proxy.size.width
            let height = proxy.size.height
            let xOffset = CGFloat(cos(angle.radians)) * width / 2
            let yOffset = CGFloat(sin(angle.radians)) * height / 2
            Text(text)
                .frame(width: width, height: height)
                .offset(x: xOffset, y: yOffset)
                .foregroundColor(.black)
        }
    }
}

struct NeedleView: View {
    enum `Type` { case hour, minute }

    var type: Type = .hour

    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: -proxy.size.height / 100) {
                if type == .hour {
                    Spacer()
                        .frame(height: proxy.size.height / 3)
                }
                Rectangle()
                    .foregroundColor(.black)
                    .cornerRadius(proxy.size.width / 2)
                Rectangle()
                    .foregroundColor(.black)
                    .frame(width: proxy.size.width / 2,
                           height: proxy.size.height / 6)
            }
        }
    }
}

struct AppleClockView: View {
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    @State private var hourNeedleAngle = Angle(radians: .pi / 4)
    @State private var minuteNeedleAngle = Angle(radians: 0)
    @State private var secondNeedleAngle = Angle(radians: .pi / 2)

    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Color.black
                    .cornerRadius(proxy.size.width / 4)

                Color.white
                    .clipShape(Circle())
                    .padding(proxy.size.width / 15)

                Group {
                    NumberView(text: "12", angle: .init(radians: -.pi / 2))
                    NumberView(text: "1", angle: .init(radians: -.pi / 3))
                    NumberView(text: "2", angle: .init(radians: -.pi / 6))
                    NumberView(text: "3", angle: .init(radians: 0))
                    NumberView(text: "4", angle: .init(radians: .pi / 6))
                    NumberView(text: "5", angle: .init(radians: .pi / 3))
                }
                .padding(proxy.size.width / 7)

                Group {
                    NumberView(text: "6", angle: .init(radians: .pi / 2))
                    NumberView(text: "7", angle: .init(radians: .pi * 2 / 3))
                    NumberView(text: "8", angle: .init(radians: .pi * 5 / 6))
                    NumberView(text: "9", angle: .init(radians: .pi))
                    NumberView(text: "10", angle: .init(radians: -.pi * 5 / 6))
                    NumberView(text: "11", angle: .init(radians: -.pi * 2 / 3))
                }
                .padding(proxy.size.width / 7)

                // Bottom most center dot
                Color.black
                    .clipShape(Circle())
                    .frame(width: proxy.size.width / 20,
                           height: proxy.size.height / 20)

                // Hour needle
                NeedleView(type: .hour)
                    .frame(width: proxy.size.width / 30,
                           height: proxy.size.height * 2 / 5)
                    .offset(x: 0, y: -proxy.size.height / 5)
                    .rotationEffect(hourNeedleAngle)

                // Minute needle
                NeedleView(type: .minute)
                    .frame(width: proxy.size.width / 30,
                           height: proxy.size.height * 2 / 5)
                    .offset(x: 0, y: -proxy.size.height / 5)
                    .rotationEffect(minuteNeedleAngle)

                // Second needle
                Color.orange
                    .frame(width: proxy.size.width / 75,
                           height: proxy.size.height / 2)
                    .cornerRadius(proxy.size.width / 60)
                    .offset(x: 0, y: -proxy.size.height / 6)
                    .rotationEffect(secondNeedleAngle)

                Color.orange
                    .clipShape(Circle())
                    .frame(width: proxy.size.width / 30,
                           height: proxy.size.height / 30)

                // Above most center dot
                Color.white
                    .clipShape(Circle())
                    .frame(width: proxy.size.width / 60,
                           height: proxy.size.height / 60)

            }
            .font(.system(size: proxy.size.width / 10))
        }
        .onReceive(timer) { _ in
            let date = Date()
            let calendar = Calendar.current
            let hour = calendar.component(.hour, from: date)
            let minute = calendar.component(.minute, from: date)
            let second = calendar.component(.second, from: date)

            minuteNeedleAngle = .init(degrees: Double(minute) / 60 * 360)

            let extraHourDegrees = Double(minute) / 60 * 6 * 5
            hourNeedleAngle = .init(degrees: Double(hour) / 12 * 360 + extraHourDegrees)

            secondNeedleAngle = .init(degrees: Double(second) / 60 * 360)
        }
    }
}

struct AppleClockView_Previews: PreviewProvider {
    static var previews: some View {
        AppleClockView()
            .frame(width: 300, height: 300, alignment: .center)
    }
}
