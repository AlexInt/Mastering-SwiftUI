//
//  FoodViewModel.swift
//  SwiftUI-Views
//
//  Created by jimmy on 2022/3/29.
//

import SwiftUI


class FoodViewModel: ObservableObject {
    @Published var offset: CGFloat = 0
    
    @Published var selectedtab = tabItems.first!.tab
}
