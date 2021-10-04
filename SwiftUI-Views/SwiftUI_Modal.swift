//
//  SwiftUI_Modal.swift
//  SwiftUI-Views
//
//  Created by jimmy on 2021/10/4.
//

import SwiftUI

struct SwiftUI_Modal: View {
    @State private var showingSheet = false
    var body: some View {
//        Button("Show Sheet") {
//            showingSheet.toggle()
//        }
//        .sheet(isPresented: $showingSheet) {
//            SheetView()
//        }
        Button("Show fullScreenCover") {
            showingSheet.toggle()
        }
        .fullScreenCover(isPresented: $showingSheet, content: FullScreenModalView.init)
    }
}

struct SwiftUI_Modal_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUI_Modal()
    }
}

struct SheetView: View {
    
//    if #available(iOS 15.0, *) {
//        @Environment(\.dismiss) var dismiss
//    } else {
//    }
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Button("Press to dismiss") {
            //    if #available(iOS 15.0, *) {
            //        dismiss()
            //    } else {
            //    }
            presentationMode.wrappedValue.dismiss()
        }
        .font(.title)
        .padding()
        .background(Color.black)
    }
}

struct FullScreenModalView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
            Color.primary.edgesIgnoringSafeArea(.all)
            Button("Dismiss Modal") {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}
