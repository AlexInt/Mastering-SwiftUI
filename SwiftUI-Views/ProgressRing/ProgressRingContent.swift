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
                //                ProgressRingView(progress: $progress, width: 380)
                
                ProgressRingView(progress: $progress, width: 320, gradient: Gradient(colors: [.lightPurple]))
                
                ProgressRingView(progress: $progress,width: 250, gradient: Gradient(colors: [.lightOrange]))
                
                ProgressRingView(progress: $progress,width: 180, gradient: Gradient(colors: [.lightGreen]))
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

/*
 The new version of Xcode 12 now makes it possible to add your custom views the library by using a new protocol called LibraryContentProvider .
 
 The way to add a view to the View library is very simple. You create a struct that conforms to LibraryContentProvider and override the views property to return an array of custom views.
 
 you can't add the documentation to your custom control.
 */
struct ProgressBar_Library: LibraryContentProvider {
    @LibraryContentBuilder var views: [LibraryItem] {
        [LibraryItem(ProgressRingView(progress: .constant(1.0),
                                     thickness: 12.0,
                                     width: 130.0,
                                     gradient: Gradient(colors: [.darkYellow, .lightYellow])),
                    title: "Progress Ring",
                    category: .control),
         LibraryItem(ProgressRingView(progress: .constant(1.0),
                                      thickness: 30.0,
                                      width: 250.0,
                                      gradient: Gradient(colors: [.darkPurple, .lightYellow])),
                     title: "Progress Ring - bigger",
                     category: .control)
        ]
    }
}

struct ProgressBarText_Library: LibraryContentProvider {
    @LibraryContentBuilder
    func modifiers(base: Circle) -> [LibraryItem] {
        LibraryItem(base.animatableProgressText(progress: 1.0),
                    title: "Progress Indicator",
                    category: .control)
    }
}

