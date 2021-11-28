//
//  CoffePhotosView.swift
//  SwiftUI-Views
//
//  Created by jimmy on 2021/11/28.
//

import SwiftUI


struct CoffePhotosView: View {
    @State var gridLayout: [GridItem] = [ GridItem() ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: gridLayout, alignment: .center, spacing: 10) {
                    ForEach(sampleCoffePhotos.indices) { index in
                        Image(sampleCoffePhotos[index].name)
                            .resizable()
                            .scaledToFill()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .frame(height: gridLayout.count == 1 ? 200 : 100)
                            .cornerRadius(10)
                            .shadow(color: .primary.opacity(0.3), radius: 1)
                    }
                }
                .padding(.all,10)
                .animation(.interactiveSpring())
            }
            .navigationTitle("Coffee feed")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        UIImpactFeedbackGenerator(style: .soft).impactOccurred(intensity: 1.0)
                        self.gridLayout = Array(repeating: .init(.flexible()),
                                                count: self.gridLayout.count % 4 + 1)
                    }) {
                        Image(systemName: "square.grid.2x2")
                            .font(.title)
                            .foregroundColor(.primary)
                    }
                }
            }
            
        }
    }
}


struct CoffePhotosView_Previews: PreviewProvider {
    static var previews: some View {
        CoffePhotosView()
    }
}
