//
//  CoffePhoto.swift
//  SwiftUI-Views
//
//  Created by jimmy on 2021/11/28.
//

import Foundation

struct CoffePhoto: Identifiable {
    var id = UUID()
    var name: String
}

let sampleCoffePhotos = (1...20).map { CoffePhoto(name: "coffee-\($0)") }


struct Cafe: Identifiable {
    var id = UUID()
    var image: String
    var coffeePhotos: [CoffePhoto] = []
}

let sampleCafes: [Cafe] = {
    var cafes = (1...18).map { Cafe(image: "cafe-\($0)") }
    for index in cafes.indices {
        let randomNumber = Int.random(in: (2...12))
        cafes[index].coffeePhotos = (1...randomNumber).map { CoffePhoto(name: "coffee-\($0)") } }
    return cafes
}()
