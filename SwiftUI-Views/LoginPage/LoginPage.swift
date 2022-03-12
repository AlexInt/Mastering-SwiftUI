//
//  LoginPage.swift
//  SwiftUI-Views
//
//  Created by jimmy on 2022/3/12.
//

import SwiftUI

struct LoginPage: View {
    @State var index = 0
    
    var body: some View{
        
        GeometryReader{_ in
            
            VStack{
                
                Image("Login_logo")
                    .resizable()
                    .frame(width: 60, height: 60)
                
                ZStack{
                    
                    SignUPView(index: self.$index)
                    // changing view order...
                        .zIndex(Double(self.index))
                    
                    LoginView(index: self.$index)
                    
                }
                
                HStack(spacing: 15){
                    
                    Rectangle()
                        .fill(Color("Login_Color1"))
                        .frame(height: 1)
                    
                    Text("OR")
                    
                    Rectangle()
                        .fill(Color("Login_Color1"))
                        .frame(height: 1)
                }
                .padding(.horizontal, 30)
                .padding(.top, 50)
                // because login button is moved 25 in y axis and 25 padding = 50
                
                HStack(spacing: 25){
                    
                    Button(action: {
                        
                    }) {
                        
                        Image("Login_apple")
                            .resizable()
                            .renderingMode(.original)
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                    }
                    
                    Button(action: {
                        
                    }) {
                        
                        Image("Login_fb")
                            .resizable()
                            .renderingMode(.original)
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                    }
                    
                    Button(action: {
                        
                    }) {
                        
                        Image("Login_twitter")
                            .resizable()
                            .renderingMode(.original)
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                    }
                }
                .padding(.top, 30)
            }
            .padding(.vertical)
        }
        .background(Color("Login_Color").edgesIgnoringSafeArea(.all))
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}

// Curve...

struct CShape : Shape {
    
    func path(in rect: CGRect) -> Path {
        
        return Path{path in
            
            // right side curve...
            
            path.move(to: CGPoint(x: rect.width, y: 100))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: 0))
            
        }
    }
}


struct CShape1 : Shape {
    
    func path(in rect: CGRect) -> Path {
        
        return Path{path in
            
            // left side curve...
            
            path.move(to: CGPoint(x: 0, y: 100))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            
        }
    }
}
