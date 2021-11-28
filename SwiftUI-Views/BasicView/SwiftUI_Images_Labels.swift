//
//  SwiftUI_Images_Labels.swift
//  SwiftUI-Views
//
//  Created by jimmy on 2021/9/12.
//

import SwiftUI
/*
 1. What's SF Symbols and how to display a system image
 2. How to display our own images
 3. How to resize an image
 4. How to display a full screen image using edgesIgnoringSafeArea How to create a circular image
 5. How to apply an overlay to an image
 */
//overlay: sometimes you may need to layer another image or text on top of an image view.
//In fact, you can apply any view as an overlay.
// the overlay modifier is not limited to Image . You can apply it to any other views.
struct SwiftUI_Images_Labels: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack {
//                SFSymbolImage()
//                ImageModify()
//                ShapeImage()
                Image("paris.jpg")
                    .resizable()  //By default, the image resizes the image using the stretch mode
                    .aspectRatio(contentMode: .fit)
//                    .overlay(
//                        Rectangle()
//                            .foregroundColor(.black)
//                            .opacity(0.4)
//                    )
//                    .overlay(
//                        Color.black     //In SwiftUI, Color is also a view.
//                            .opacity(0.4)
//                    )  // the same effect
                    .overlay(
                        Color.black
                            .opacity(0.4)
                            .overlay(
                                Text("Paris")
                                    .font(.largeTitle)
                                    .fontWeight(.black)
                                    .foregroundColor(.white)
                                    .frame(width: 200)
                            )
                    )
                    

            }
        }
        
    }
}

struct ShapeImage: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: true) {
            ZStack {
                Color.orange.opacity(0.35)
                HStack(spacing: 30.0) {
                    Image("paris.jpg")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 300)
                        .clipShape(Circle())
                        .overlay(
                            Image(systemName: "heart.fill")
                                .font(.system(size: 50))
                                .foregroundColor(.red)
                                .opacity(0.5)
                        )
                    Image("paris.jpg")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 200)
                        .clipShape(Ellipse())
                    Image("paris.jpg")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 200)
                        .clipShape(Capsule())
                }
            }
        }
    }
}

struct ImageModify: View {
    var body: some View {
        ZStack {
            Color.gray.opacity(0.5)
            Image("paris.jpg")
                .resizable() //original image will be scaled to fill the whole screen
    //            .edgesIgnoringSafeArea(.all)
    //            .scaledToFit()
    //            .aspectRatio(contentMode: .fit) //same effect
                .aspectRatio(contentMode: .fill)
                .frame(width: 300)
                .clipped()
                .overlay(
                    Text("If you are lucky enough to have lived in Paris as a young man, then wherever you go for the rest of your life it stays with you, for Paris is a moveab le feast.\n\n- Ernest Hemingway")
                        .fontWeight(.heavy)
                        .font(.system(.headline, design: .rounded))
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black)
                        .cornerRadius(10)
                        .opacity(0.7)
                        .padding(),
                    alignment: .top  //default is .center
                )
        } //use the clipped modifier to eliminate extra parts of the view.
    }
}

struct SFSymbolImage: View {
    var body: some View {
        ZStack {
            Image(systemName: "cloud.heavyrain")
                .font(.system(size: 100))
                .foregroundColor(.blue)
                .shadow(color: .gray, radius: 10, x: 0.0, y: 10.0)
        }
    }
}

struct SwiftUI_Images_Labels_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUI_Images_Labels()
    }
}
