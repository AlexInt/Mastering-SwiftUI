//
//  CardTransaction.swift
//  SwiftUI-Views
//
//  Created by jimmy on 2021/10/7.
//

import Foundation

struct CardTransaction: Identifiable {
    var id = UUID()
    var merchant: String
    var amount: Double
    var date: String
    var icon: String = "dollarsign.circle.fill"
}

let testTransactions = [
    CardTransaction(merchant: "Mushroom", amount: 120.0, date: "11/2/2020", icon: "star.circle.fill"),
    CardTransaction(merchant: "Amazon", amount: 50.0, date: "10/2/2020", icon: "cart.fill"),
    CardTransaction(merchant: "MUJI", amount: 300.0, date: "8/2/2020", icon: "app.gift.fill"),
    CardTransaction(merchant: "Apple", amount: 800.0, date: "4/2/2020", icon: "headphones"),
    CardTransaction(merchant: "Netflix", amount: 19.0, date: "11/2/2020", icon: "tv"),
    CardTransaction(merchant: "ANA", amount: 480.0, date: "11/2/2020", icon: "airplane")
]
