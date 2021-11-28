//
//  SwiftUI_Webview.swift
//  SwiftUI-Views
//
//  Created by jimmy on 2021/10/26.
//

import SwiftUI
import WebKit

struct SwiftUI_Webview: View {
    
    @State private var showWebView = false
    @State private var animateGradient = false
    
    var body: some View {
        ZStack {
            //duration set to 1.5
//            LinearGradient(colors: [.purple,.yellow],
//                           startPoint: animateGradient ? .topLeading : .bottomLeading,
//                           endPoint: animateGradient ? .bottomTrailing : .topTrailing)
            
            //like heart beat, duration set to 0.8
            RadialGradient(colors: [.purple, .yellow],
                           center: .center,
                           startRadius: animateGradient ? 400 : 150,
                           endRadius: animateGradient ? 20 : 40)
            
            //duration set to 5.0
//            LinearGradient(colors: [.purple, .yellow],
//                           startPoint: .topLeading,
//                           endPoint: .bottomTrailing)
//                .hueRotation(.degrees(animateGradient ? 45 : 0))
            
            Button(action: {
                showWebView.toggle()
            }) {
                Text("Google it")
                    .font(.system(size: 65, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
            }
        }
        .ignoresSafeArea()
        .onAppear {
            withAnimation(.linear(duration: 0.8).repeatForever(autoreverses: true)) {
                animateGradient.toggle()
            }
        }
        .sheet(isPresented: $showWebView) {
            WebView(url: URL(string: "https://www.google.com/")!)
        }
    }
}

struct SwiftUI_Webview_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUI_Webview()
    }
}

struct WebView: UIViewRepresentable {
    var url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}

