//
//  PFBlankView.swift
//  PFinance
//
//  Created by Simon Ng on 11/9/2020.
//

import SwiftUI

struct PFBlankView : View {
    
    var bgColor: Color
    
    var body: some View {
        VStack {
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(bgColor)
        .edgesIgnoringSafeArea(.all)
    }
}

struct PFBlankView_Previews: PreviewProvider {
    static var previews: some View {
        PFBlankView(bgColor: .black)
    }
}
