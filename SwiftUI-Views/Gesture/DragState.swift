//
//  DragState.swift
//  SwiftUI-Views
//
//  Created by jimmy on 2021/10/6.
//

import UIKit

enum DragState {
    case inactive
    case pressing
    case dragging(translation: CGSize)
    
    var translation: CGSize {
        switch self {
        case .inactive, .pressing:
            return .zero
        case .dragging(let translation):
            return translation
        }
    }
    
    var isDragging: Bool {
        switch self {
        case .inactive:
            return false
        case .pressing:
            return false
        case .dragging:
            return true
        }
    }
    
    var isPressing: Bool {
        switch self {
        case .dragging, .pressing:
            return true
        case .inactive:
            return false
        }
    }
}

//enum DraggableState {
//    case inactive
//    case pressing
//    case dragging(translation:CGSize)
//    
//    var translation: CGSize {
//        switch self {
//        case .inactive, .pressing:
//            return .zero
//        case .dragging(let translation):
//            return translation
//        }
//    }
//    
//    var isPressing: Bool {
//        switch self {
//        case .dragging, .pressing:
//            return true
//        case .inactive:
//            return false
//        }
//    }
//}
