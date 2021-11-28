//
//  ProgressRingContent.swift
//  SwiftUI-Views
//
//  Created by jimmy on 2021/11/28.
//

import SwiftUI

struct ProgressRingContent: View {
    @State var progress = 0.0
    var body: some View {
        VStack {
            ZStack {
                ProgressRingView(progress: $progress, width: 320)
                
                ProgressRingView(progress: $progress, width: 250, gradient: Gradient(colors: [.lightPurple]))
                
                ProgressRingView(progress: $progress,width: 180, gradient: Gradient(colors: [.lightOrange]))
                
                ProgressRingView(progress: $progress,width: 110, gradient: Gradient(colors: [.lightGreen]))
            }
            HStack {
                Group {
                    Text("25%")
                        .font(.system(.headline, design: .rounded))
                        .onTapGesture {
                            UIImpactFeedbackGenerator(style: .soft).impactOccurred()
                            self.progress = 0.25
                        }
                    Text("50%")
                        .font(.system(.headline, design: .rounded))
                        .onTapGesture {
                            UIImpactFeedbackGenerator(style: .soft).impactOccurred()
                            self.progress = 0.5
                        }
                    Text("75%")
                        .font(.system(.headline, design: .rounded))
                        .onTapGesture {
                            UIImpactFeedbackGenerator(style: .soft).impactOccurred()
                            self.progress = 0.75
                        }
                    Text("100%")
                        .font(.system(.headline, design: .rounded))
                        .onTapGesture {
                            UIImpactFeedbackGenerator(style: .soft).impactOccurred()
                            self.progress = 1.0
                        }
                }
                .padding()
                .background(Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 15.0, style: .continuous))
                .padding(.horizontal,5)
            }
            .padding(.top, 30)
            .padding(.horizontal, 5)
            
        }
    }
}

struct ProgressRingContent_Previews: PreviewProvider {
    static var previews: some View {
        ProgressRingContent()
    }
}
