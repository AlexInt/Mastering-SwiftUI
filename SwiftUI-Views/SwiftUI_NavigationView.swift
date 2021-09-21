//
//  SwiftUI_NavigationView.swift
//  SwiftUI-Views
//
//  Created by jimmy on 2021/9/21.
//

import SwiftUI

struct SwiftUI_NavigationView: View {
    var body: some View {
        NavigationView {
            List(restaurants) {
                BasicImageRow(restaurant: $0)
            }
            .navigationTitle("Restaurants")
        }
    }
}

struct SwiftUI_NavigationView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUI_NavigationView()
    }
}
