//
//  SwiftUI_ContextMenu.swift
//  SwiftUI-Views
//
//  Created by jimmy on 2021/10/4.
//

import SwiftUI

/*
 SwiftUI gives us the ContextMenu modifier for creating popup menus in our apps. In iOS this is usually triggered with a long press, but it works just the same as a right-click on macOS – it’s a flexible API.

 A context menu is built from a collection of buttons, each with their own action, text, and icon. The text and icon can be provided directly inside the button, because SwiftUI will provide an implicit HStack to make sure they fit the system standard look and feel.
 */
struct SwiftUI_ContextMenu: View {
    var body: some View {
        Text("Options")
            .contextMenu {
                Button {
                    print("Change country setting")
                } label: {
                    Label("Choose Country", systemImage: "globe")
                }
                
                Button {
                    print("Enable geolocation")
                } label: {
                    Label("Detect Location", systemImage: "location.circle")
                }
            }
    }
}

struct SwiftUI_ContextMenu_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUI_ContextMenu()
    }
}
