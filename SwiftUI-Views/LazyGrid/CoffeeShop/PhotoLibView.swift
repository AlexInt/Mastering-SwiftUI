//
//  PhotoLibView.swift
//  SwiftUI-Views
//
//  Created by jimmy on 2021/11/28.
//

import SwiftUI

struct PhotoLibView: View {
    @State private var photoSet = sampleCoffePhotos
    @State private var selectedPhotos: [CoffePhoto] = []
    @State private var selectedPhotoId: UUID?
    @Namespace private var photoTransition
    
    var body: some View {
        VStack {
            
            // content view
            ScrollView {
                HStack {
                    Text("Photos")
                        .font(.system(.title, design: .rounded))
                        .fontWeight(.heavy)
                    
                    Spacer()
                }
                
                LazyVGrid(columns: [ GridItem(.adaptive(minimum: 50)) ]) {
                    ForEach(photoSet) { photo in
                        Image(photo.name)
                            .resizable()
                            .scaledToFill()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .frame(height: 60)
                            .cornerRadius(3.0)
                            .matchedGeometryEffect(id: photo.id, in: photoTransition)
                            .onTapGesture {
                                selectedPhotos.append(photo)
                                selectedPhotoId = photo.id
                                if let index = photoSet.firstIndex(where: { $0.id == photo.id }) {
                                    photoSet.remove(at: index)
                                }
                            }
                    }
                }
            }
            
            /*
             When a photo is selected, we will remove it from the photo grid and insert it into the dock
             */
            
            // dock view
            ScrollViewReader { scrollProxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    LazyHGrid(rows: [ GridItem() ]) {
                        
                        ForEach(selectedPhotos) { photo in
                            
                            Image(photo.name)
                                .resizable()
                                .scaledToFill()
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .frame(height: 100)
                                .cornerRadius(3.0)
                                .id(photo.id)
                                .matchedGeometryEffect(id: photo.id, in: photoTransition)
                                .onTapGesture {
                                    photoSet.append(photo)
                                    if let index = selectedPhotos.firstIndex(where: { $0.id == photo.id }) {
                                        selectedPhotos.remove(at: index)
                                    }
                                }
                        }
                    }
                    
                }
                .frame(height: 100)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(5)
                .onChange(of: selectedPhotoId, perform: { id in
                    guard id != nil else { return }
                    scrollProxy.scrollTo(id)
                })
            }
        }
        .padding()
        .animation(.interactiveSpring())
    }
}

struct PhotoLibView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoLibView()
    }
}
