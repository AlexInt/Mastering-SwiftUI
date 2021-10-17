//
//  KeyboardResponder.swift
//  SwiftUI-Views
//
//  Created by jimmy on 2021/10/17.
//

import Foundation
import UIKit

class KeyboardResponder: ObservableObject {
    private var _center: NotificationCenter
    @Published var currentHeight: CGFloat = 0
    var showKeyboard: Bool {
        currentHeight > 0
    }
    private var lastHeight: CGFloat = 0

    init(center: NotificationCenter = .default) {
        _center = center
        _center.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        _center.addObserver(self, selector: #selector(keyBoardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    deinit {
        _center.removeObserver(self)
    }

    @objc func keyBoardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if keyboardSize.height >= lastHeight{
                currentHeight = keyboardSize.height
                lastHeight = currentHeight
            } else {
                currentHeight = lastHeight
            }
        }
    }

    @objc func keyBoardWillHide(notification: Notification) {
        currentHeight = 0
    }
}
