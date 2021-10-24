//
//  AutoResize.swift
//  SwiftUI-Views
//
//  Created by jimmy on 2021/10/24.
//

import SwiftUI

struct AutoResize: View {
    @State private var txt = ""
    @State private var value: CGFloat = 0
    @ObservedObject private var keyboard = KeyboardResponder()
    
    var body: some View {
        VStack {
            List(1..<100) {_ in
                Text("many rows ")
            }
            
            TextField("Type something", text: $txt)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 15)
        }
        .padding(.bottom, keyboard.currentHeight)
//        .offset(y:-self.value)
//        .animation(.spring())
//        .onAppear {
//            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { noti in
//                let rect = noti.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
//                let kbHeight = rect.height
//                print(kbHeight)
////                self.value = kbHeight
//            }
//
//            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { noti in
//                self.value = 0
//            }
//
//        }
    }
}

struct AutoResize_Previews: PreviewProvider {
    static var previews: some View {
        AutoResize()
    }
}
