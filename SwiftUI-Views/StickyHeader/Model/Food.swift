//
//  Food.swift
//  SwiftUI-Views
//
//  Created by jimmy on 2022/3/29.
//

import SwiftUI
//food model and sample food items

struct Food: Identifiable {
    var id = UUID().uuidString
    var title: String
    var description: String
    var price: String
    var image: String
}

var foods = [
    Food(title: "Chocolate", description: "Chocolate is a food product made from roasted and ground cacao pods, that is available as a liquid, solid or paste, on its own or as a flavoring agent in other foods. Cacao has been consumed in some form since at least the Olmec civilization and the majority of Mesoamerican people - including the Maya and Aztecs - made chocolate beverages", price: "$19", image: "chocolate"),
    Food(title: "Cookies", description: "A cookie is a baked or cooked snack or dessert that is typically small, flat and sweet. It usually contains flour, sugar, egg, and some type of oil, fat, or butter. It may include other ingredients such as raisins, oats, chocolate chips, nuts, etc.", price: "$10", image: "cookies"),
    Food(title: "Sandwich", description: "A sandwich is a food typically consisting of vegetables, sliced cheese or meat, placed on or between slices of bread, or more generally any dish wherein bread serves as a container or wrapper for another food type. The sandwich began as a portable, convenient finger food in the Western world, though over time it has become prevalent worldwide.", price: "$9", image: "sandwich"),
    Food(title: "French Fries", description: "French fries (North American English), chips (British English),[1] finger chips (Indian English), french-fried potatoes, or simply fries, are batonnet or allumette-cut[3] deep-fried potatoes, originating from either Belgium or France. They are prepared by cutting the potato into even strips, then drying and frying it, usually in a deep fryer. Most french fries are produced from frozen russet potatoes.", price: "$15", image: "fries"),
    Food(title: "Pizza", description: "Pizza (Italian: [ˈpittsa], Neapolitan: [ˈpittsə]) is a dish of Italian origin consisting of a usually round, flat base of leavened wheat-based dough topped with tomatoes, cheese, and often various other ingredients (such as anchovies, mushrooms, onions, olives, pineapple, meat, etc.), which is then baked at a high temperature, traditionally in a wood-fired oven. A small pizza is sometimes called a pizzetta. A person who makes pizza is known as a pizzaiolo.", price: "$39", image: "pizza"),
]
