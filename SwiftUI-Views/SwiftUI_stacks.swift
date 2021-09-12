//
//  SwiftUI_stacks.swift
//  SwiftUI-Views
//
//  Created by jimmy on 2021/9/12.
//
/*
 HStack - arranges the views horizontally
 VStack - arranges the views vertically
 ZStack - overlays one view on top of the others
 */
import SwiftUI

struct SwiftUI_stacks: View {
    var body: some View {
        VStack {
            HeaderView()


            HStack(spacing: 15.0) {
                PricingView(title: "Basic",
                            price: "$9",
                            textColor: .white,
                            bgColor: .purple)
                ZStack {
                    PricingView(title: "Pro", price: "$19", textColor: .black, bgColor: Color(red:240/255, green: 240/255, blue: 240/255))
                    Text("Best for designer")
                        .font(.system(.caption, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(5)
                        .background(Color(red: 255/255, green: 183/255, blue: 37/255))
                        .offset(x: 0, y: 87)
                }

            }
            .padding(.horizontal)


            ZStack {
                PricingView(title: "Team",
                            price: "$299",
                            textColor: .white,
                            bgColor: Color(red: 62/255, green: 63/255, blue: 70/255),
                            icon: "wand.and.rays")
                    .padding()

                Text("Perfect for teams with 20 members")
                    .font(.system(.caption, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(5)
                    .background(Color(red: 255/255, green: 183/255, blue: 37/255)) .offset(x: 0, y: 87)
            }

            Spacer()
        }
        
//        ZStack {
//            PricingView(title: "Basic", price: "$9", textColor: .white, bgColor: .purple, icon: "burst.fill")
//                .padding()
//                .offset(x: 0, y: 180)
//
//            PricingView(title: "Pro", price: "$19", textColor: .white, bgColor: Color(red: 255/255, green: 183/255, blue: 37/255), icon: "dial")
//                .padding()
//                .scaleEffect(0.95)
//
//            PricingView(title: "Team", price: "$299", textColor: .white, bgColor: Color(red: 62/255, green: 63/255, blue: 70/255), icon: "wand.and.rays")
//                .padding()
//                .scaleEffect(0.9)
//                .offset(x: 0, y: -180)
//        }
//
        
    }
}

struct HeaderView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2.0) {
                Text("Choose")
                    .font(.system(.largeTitle, design: .rounded))
                    .fontWeight(.black)
                Text("Your Plan")
                    .font(.system(.largeTitle, design: .rounded))
                    .fontWeight(.black)
            }
            Spacer()
        }
        .padding()
    }
}

struct SwiftUI_stacks_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUI_stacks()
    }
}

struct PricingView: View {
    var title: String
    var price: String
    var textColor: Color
    var bgColor: Color
    var icon: String?
    
    var body: some View {
        VStack {
//            if let icon = icon {
//                Image(systemName: icon)
//                    .font(.largeTitle)
//                    .foregroundColor(textColor)
//            }
            icon.map{
                Image(systemName: $0)
                    .font(.largeTitle)
                    .foregroundColor(textColor)
            }
            Text(title)
                .font(.system(.title, design: .rounded))
                .fontWeight(.black)
                .foregroundColor(textColor)
            Text(price)
                .font(.system(size: 40, weight: .heavy, design: .rounded))
                .foregroundColor(textColor)
            Text("per month")
                .font(.headline)
                .foregroundColor(textColor)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 100)  //must be here
        .padding(40)
        .background(bgColor)
        .cornerRadius(10)
    }
}
