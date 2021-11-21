//
//  ICTripDetailView.swift
//  SwiftUI-Views
//
//  Created by jimmy on 2021/11/21.
//

import SwiftUI

struct ICTripDetailView: View {
    let destination: String
    
    var body: some View {
        GeometryReader{geo in
            ScrollView(.vertical, showsIndicators: true) {
                ZStack {
                    VStack(alignment: .leading, spacing: 5){
                        
                        VStack(alignment: .leading, spacing: 5){
                            Text(self.destination)
                                .font(.system(.title, design: .rounded))
                                .fontWeight(.heavy)
                            
                            HStack(spacing: 3) {
                                ForEach(1...5, id: \.self) {_ in
                                    Image(systemName: "star.fill")
                                        .foregroundColor(.yellow)
                                        .font(.system(size: 15))
                                }
                                
                                Text("5.0")
                                    .font(.system(.headline))
                                    .padding(.leading, 10)
                            }
                        }
                        .padding(.bottom, 30)
                        
                        Text("Description")
                            .font(.system(.headline))
                            .fontWeight(.medium)
                        
                        Text("Growing up in Michigan, I was lucky enough to experi ence one part of the Great Lakes. And let me assure you, they are great. As a phot ojournalist, I have had endless opportunities to travel the world and to see a var iety of lakes as well as each of the major oceans. And let me tell you, you will be hard pressed to find water as beautiful as the Great Lakes.")
                            .padding(.bottom, 40)
                        Button(action: {
                            
                        }) {
                           Text("Book Now")
                                .font(.system(.headline, design: .rounded))
                                .fontWeight(.heavy)
                                .foregroundColor(.white)
                                .padding()
                                .frame(minWidth:0, maxWidth: .infinity)
                                .background(Color(red: 0.97, green: 0.369, blue: 0.212))
                                .cornerRadius(20)
                        }
                    }
                    .padding()
                    .frame(width: geo.size.width, height: geo.size.height, alignment: .topLeading)
                    .background(Color.white)
                    .cornerRadius(15)
                    
                    Image(systemName: "bookmark.fill")
                        .font(.system(size: 40))
                        .foregroundColor(Color(red: 0.97, green: 0.369, blue: 0.212))
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topTrailing)
                        .offset(x: -15, y: -5)
                }
                .offset(y:15)
            }
        }
    }
}

struct ICTripDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ICTripDetailView(destination: "London").background(Color.black)
    }
}
