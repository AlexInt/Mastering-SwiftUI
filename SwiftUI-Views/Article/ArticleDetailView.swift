//
//  ArticleDetailView.swift
//  SwiftUI-Views
//
//  Created by jimmy on 2021/10/3.
//

import SwiftUI

struct ArticleDetailView: View {
    var article: ArticleDetail
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showAlert = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Image(article.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                Group {
                    Text(article.title)
                        .font(.system(.title, design: .rounded))
                        .fontWeight(.black)
                        .lineLimit(3)
                    
                    Text("By \(article.author)".uppercased())
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.bottom, 0)
                .padding(.horizontal)
                
                Text(article.content)
                    .font(.body)
                    .padding()
                    .lineLimit(1000)
                    .multilineTextAlignment(.leading)
            }
        }
        .edgesIgnoringSafeArea(.top)
        
        //for dismiss navigation page
//        .navigationBarBackButtonHidden(true)
//        .navigationBarItems(leading:
//            Button(action: {
//                self.presentationMode.wrappedValue.dismiss()
//            }, label: {
//                Image(systemName: "chevron.left.circle.fill")
//                    .font(.largeTitle)
//                    .foregroundColor(.white)
//            })
//        )
        
        //for dismiss modal page
        .overlay(
            HStack {
                Spacer()
                VStack {
                    Button(action: {
//                        self.presentationMode.wrappedValue.dismiss()
                        self.showAlert = true
                    }) {
                        Image(systemName: "chevron.down.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    }
                    .padding(.trailing, 20)
                    .padding(.top, 0) //full screen 0, otherwise 40
                    
                    Spacer()
                }
            }
        )
        
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Reminder"),
                  message: Text("Are you sure you finish reading the article?"),
                  primaryButton: .default(Text("Yes"),
                                          action: { self.presentationMode.wrappedValue.dismiss() }),
                  secondaryButton: .cancel(Text("No"))
            )
        }
    }
}

struct ArticleDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ArticleDetailView(article: DetailArticles[0])
        }
    }
}

