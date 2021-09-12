//
//  SwiftUI_Buttons_Labels_Gradient.swift
//  SwiftUI-Views
//
//  Created by jimmy on 2021/9/12.
//
/*
 1. How to create a simple button and handle the user's selection
 2. How to customize the button's background, padding and font
 3. How to add borders to a button
 4. How to create a button with both image and text
 5. How to create a button with a gradient background and shadows
 6. How to create a full-width button
 7. How to create a reusable buttons tyle
 8. How to add a tap animation
 */
/*
 Button(action: {
 // What to perform:
 the code to perform after the button is tapped or selected by the user.
 The button is now non-tappable in the design canvas. only for run
 }) {
 // How the button looks like
 the code block that describes the look & feel of the button.
 }
 */

import SwiftUI

struct SwiftUI_Buttons_Labels_Gradient: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack{
                VStack(spacing: 20.0) {
                    Text("The Order of Modifiers is Important!!!")
                        .font(.system(.title3, design: .rounded))
                        .foregroundColor(.red)
                    
                    
                    Button(action: {
                        print("Hello World tapped!")
                    }) {
                        Text("Padding Last")
                            .background(Color.purple) // 1. Change the background color to purple
                            .foregroundColor(.white)  // 2. Set the foreground/font color to white
                            .font(.title)             // 3. Change the font type
                            .padding()   // 4. Add the paddings with the primary color (i.e.white)
                            .border(Color.red,width: 1)
                    }
                    
                    
                    Button(action: {
                        print("Padding")
                    }) {
                        Text("Padding First")
                            .padding()   // 1. Add the paddings
                            .background(Color.purple)// 2. Change the background color to purple including the padding
                            .foregroundColor(.white)// 3. Set the foreground/font color to white
                            .font(.title)// 4. Change the font type
                            .border(Color.green, width: 3)
                    }
                    
                    Button(action: {
                        
                    }, label: {
                        Text("Two padding")
                            .fontWeight(.bold)
                            .font(.title)
                            .padding()
                            .background(Color.purple)
                            .cornerRadius(40)
                            .foregroundColor(.white)
                            .padding(10)
                            //                    .border(Color.purple, width: 5)
                            .overlay(
                                RoundedRectangle(cornerRadius: 40)
                                    .stroke(Color.purple,lineWidth: 5)
                            )
                    })
                    /*
                     We use two padding modifiers to create the button design. The first padding , together with the background modifier, is for creating a button with padding and purple background. The padding(10) modifier adds extra paddings around the button and the border modifier specifies to paint a rounded border in purple.
                     
                     The overlay modifier lets you overlay another view on top of the current view. In the code, what we did was to draw a border with rounded corners using the stroke modifier of the RoundedRectangle object. The stroke modifier allows you to configure the color and line width of the stroke.
                     */
                }
                VStack {
                    //Creating a Button with Images and Text
                    Button(action: {
                        print("Delete button tapped!")
                    }, label: {
                        Image(systemName: "trash")
                            .font(.largeTitle)
                            .foregroundColor(.red)
                    })
                    
                    
                    Button(action: {
                        print("Delete button tapped!")
                    }, label: {
                        Image(systemName: "trash")
                            .padding()
                            .background(Color.red)
                            .clipShape(Circle())
                            .font(.largeTitle)
                            .foregroundColor(.white)
                        
                    })
                    
                    
                    Button(action: {
                        print("Delete tapped!")
                    }) {
                        HStack {
                            Image(systemName: "trash")
                                .font(.title)
                            Text("Delete")
                                .fontWeight(.semibold)
                                .font(.title)
                        }
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.red)
                        .cornerRadius(40)
                    }
                    
                    /*
                     In iOS 14, the SwiftUI framework introduces a new view called Label that lets you place an image and text side by side.
                     */
                    Button(action: {
                        print("Delete tapped!")
                    }) {
                        Label(
                            title: { Text("Delete")
                                .fontWeight(.semibold)
                                .font(.title)
                            },
                            icon: { Image(systemName: "trash")
                                .font(.title)
                            }
                        )
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.red)
                        .cornerRadius(40)
                    }
                    
                    // Gradient Background and Shadow
                    Button(action: {
                        print("Delete tapped!")
                    }) {
                        /*
                         In iOS 14, the SwiftUI framework introduces a new view called Label that lets you place an image and text side by side.
                         */
                        Label(
                            title: { Text("Delete")
                                .fontWeight(.semibold)
                                .font(.title)
                            },
                            icon: { Image(systemName: "trash")
                                .font(.title)
                            }
                        )
                        .padding()
                        .foregroundColor(.white)
                        .background(LinearGradient(gradient: Gradient(colors: [Color("DarkGreen"), Color("LightGreen")]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(40)
                        .shadow(color: .gray, radius: 20.0, x: 20, y: 10)
                    }
                    
                    //                Creating a Full-width Button
                    //                Button(action: {
                    //                    print("Delete tapped!")
                    //                }, label: {
                    //                    HStack {
                    //                        Image(systemName: "trash")
                    //                            .font(.title)
                    //                        Text("Delete")
                    //                            .fontWeight(.semibold)
                    //                            .font(.title)
                    //                    }
                    //                    .frame(minWidth: 0, maxWidth: .infinity)
                    //                    .padding()
                    //                    .foregroundColor(.white)
                    //                    .background(LinearGradient(gradient: Gradient(colors: [Color("DarkGreen"), Color("LightGreen")]), startPoint: .leading, endPoint: .trailing))
                    //                    .cornerRadius(40)
                    //                    .padding(.horizontal, 15)
                    //                })
                    
                    //Styling Buttons with ButtonStyle
                    
                    Button(action: {
                        print("Delete tapped!")
                    }) {
                        HStack {
                            Image(systemName: "trash")
                                .font(.title)
                            Text("Delete")
                                .fontWeight(.semibold)
                                .font(.title)
                        }
                    }
                    .buttonStyle(GradientBackgroundStyle())
                    
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "plus")
                            .font(.largeTitle)
                    })
                    .buttonStyle(ClockWiseStyle())
                }
            }
        }
    }
}

struct GradientBackgroundStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .foregroundColor(.white)
            .background(LinearGradient(gradient:
                                        Gradient(colors: [Color("DarkGreen"), Color("LightGreen")]),
                                       startPoint: .leading,
                                       endPoint: .trailing))
            .cornerRadius(40)
            .padding(.horizontal, 20)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
    }
}

struct ClockWiseStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 40, height: 40)
            .foregroundColor(.white)
            .padding()
            .background(Color.purple)
            .cornerRadius(40)
            .rotationEffect(configuration.isPressed ? .degrees(45) : .zero, anchor: .center)
    }
}

struct SwiftUI_Buttons_Labels_Gradient_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUI_Buttons_Labels_Gradient()
    }
}
