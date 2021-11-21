//
//  ICTrip.swift
//  SwiftUI-Views
//
//  Created by jimmy on 2021/11/21.
//

import Foundation

//IC Image Carousel for short
struct ICTrip: Identifiable {
    var id = UUID()
    var destination: String
    var image: String
}


#if DEBUG
let sampleICTrips = [ICTrip(destination: "Paris", image: "paris"),
                    ICTrip(destination: "Florence", image: "florence"),
                    ICTrip(destination: "Amsterdam", image: "amsterdam"),
                    ICTrip(destination: "Ghent", image: "ghent"),
                    ICTrip(destination: "Santorini", image: "santorini"),
                    ICTrip(destination: "Budapest", image: "budapest"),
                    ICTrip(destination: "London", image: "london"),
                    ICTrip(destination: "Cuba", image: "cuba"),
                    ICTrip(destination: "Osaka", image: "osaka"),
                    ICTrip(destination: "Kyoto", image: "kyoto"),
                    ICTrip(destination: "Seoul", image: "seoul"),
                    ICTrip(destination: "Sydney", image: "sydney"),
                    ICTrip(destination: "Hong Kong", image: "hongkong")
]
#endif

