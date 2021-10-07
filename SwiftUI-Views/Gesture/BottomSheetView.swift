//
//  BottomSheetView.swift
//  SwiftUI-Views
//
//  Created by jimmy on 2021/10/7.
//

import SwiftUI

fileprivate enum Constants {
    static let radius: CGFloat = 16
    static let handlebarHeight: CGFloat = 6
    static let handlebarWidth: CGFloat = 60
    static let snapRatio: CGFloat = 0.25
    static let minHeightRatio: CGFloat = 0.5
}


struct BottomSheetView<Content: View>: View {
    @Binding var isOpen: Bool
    
    let maxHeight: CGFloat
    let minHeight: CGFloat
    let content: Content
    
    @GestureState private var translation: CGFloat = 0
    
    private var offset: CGFloat {
        isOpen ? 0 : maxHeight - minHeight
    }
    
    
    private var handlebar: some View {
        RoundedRectangle(cornerRadius: Constants.radius)
            .fill(Color.secondary)
            .frame(
                width: Constants.handlebarWidth,
                height: Constants.handlebarHeight
            )
    }
    
    //You typically use ViewBuilder as a parameter attribute for child view-producing closure parameters, allowing those closures to provide multiple child views
    init(isOpen: Binding<Bool>,
         maxHeight: CGFloat,
         @ViewBuilder content: () -> Content) {
        
        self.minHeight = maxHeight * Constants.minHeightRatio
        self.maxHeight = maxHeight
        self.content = content()
        self._isOpen = isOpen
    }
    
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                self.handlebar.padding()
                self.content
            }
            .frame(width: geometry.size.width, height: self.maxHeight, alignment: .top)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(Constants.radius)
            .frame(height: geometry.size.height, alignment: .bottom)
            .offset(y: max(self.offset + self.translation, 0))
            .animation(.interactiveSpring(), value: isOpen)
            .animation(.interactiveSpring(), value: translation)
            .gesture(
                DragGesture()
                    .updating(self.$translation) { value, state, _ in
                        state = value.translation.height
                    }
                    .onEnded { value in
                        let snapDistance = self.maxHeight * Constants.snapRatio
                        guard abs(value.translation.height) > snapDistance else {
                            return
                        }
                        self.isOpen = value.translation.height < 0
                    }
            )
        }
    }
}


struct BottomSheetView_Previews: PreviewProvider {
    static var previews: some View {
//        BottomSheetView(isOpen: .constant(false), maxHeight: 600) {
//            Rectangle().fill(Color.red)
//        }.edgesIgnoringSafeArea(.all)
        ParentDemoView()
    }
}

struct ParentDemoView: View {
    @State private var bottomSheetShown = false
    
    var body: some View {
        GeometryReader { geometry in
            Color(.systemGray)
            BottomSheetView(
                isOpen: self.$bottomSheetShown,
                maxHeight: geometry.size.height * 0.9
            ) {
                Color.orange
            }
        }.edgesIgnoringSafeArea(.all)
    }
}
