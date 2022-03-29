//
//  FoodTab.swift
//  SwiftUI-Views
//
//  Created by jimmy on 2022/3/29.
//

import Foundation

//Tab model with tab items

struct FoodTab: Identifiable {
    var id = UUID().uuidString
    var tab: String
    var foods: [Food]
}

var tabItems = [
    FoodTab(tab: "Order Again", foods: foods.shuffled()),
    FoodTab(tab: "Picked for you", foods: foods.shuffled()),
    FoodTab(tab: "Starters", foods: foods.shuffled()),
    FoodTab(tab: "Gimpub Sushi", foods: foods.shuffled())
]
