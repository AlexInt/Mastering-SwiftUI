//
//  NeumorphismView.swift
//  SwiftUI-Views
//
//  Created by jimmy on 2022/3/17.
//

import SwiftUI

struct NeumorphismView: View {
    var body: some View {
        ZStack {
            Color.gray.opacity(0.7)
            VStack(spacing: 15.0) {
                NeumorphismDark()
                Text("新拟态-Neumorphism")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                NeumorphismLight()
            }
        }
    }
}

struct NeumorphismView_Previews: PreviewProvider {
    static var previews: some View {
        NeumorphismView()
    }
}
