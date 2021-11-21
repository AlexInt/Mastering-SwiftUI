//
//  ArticleCardView.swift
//  SwiftUI-Views
//
//  Created by jimmy on 2021/11/21.
//

import SwiftUI

struct ArticleCardView: View {
    
    let category: String
    let headline: String
    let subHeadline: String
    let image: UIImage
    var content: String = ""
    @Binding var isShowContent: Bool
    
    
    var body: some View {
        GeometryReader{geo in
            ZStack(alignment: .topTrailing) {
                ScrollView {
                    VStack(alignment: .leading) {
                        Image(uiImage: self.image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: geo.size.width,
                                   height: self.isShowContent ? geo.size.height * 0.7 : min(self.image.size.height/3, 500))
                            .border(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), width: self.isShowContent ? 0 : 1)
                            .cornerRadius(15)
                            .overlay(
                                ArticleExcerptView(category: self.category, headline: self.headline, subHeadline: self.subHeadline, isShowContent: self.$isShowContent)
                                    .cornerRadius(self.isShowContent ? 0: 15)
                            )
                        
                        // Content
                        if self.isShowContent {
                            Text(self.content)
                                .foregroundColor(Color(.darkGray))
                                .font(.system(.body, design: .rounded))
                                .padding(.horizontal)
                                .padding(.bottom, 50)
                                .transition(.move(edge: .top))
                                .animation(.linear)
                        }
                    }
                }
                .shadow(color: Color.init(.sRGB, red: 64/255, green: 64/255, blue: 64/255, opacity: 0.3),
                    radius: self.isShowContent ? 0 : 15)
                
                //close button
                if self.isShowContent {
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            self.isShowContent = false
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .font(.system(size: 26))
                                .foregroundColor(.white)
                                .opacity(0.7)
                        }
                    }
                    .padding(.top, 50)
                    .padding(.trailing)
                    .shadow(color: Color.init(.sRGB, red: 64/255, green: 64/255, blue: 64/255, opacity: 0.95),
                        radius: 3)
                }
            }
        }
    }
}

struct ArticleCardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ArticleCardView(category: appStoreArticles[0].category,
                            headline: appStoreArticles[0].headline,
                            subHeadline: appStoreArticles[0].subHeadline,
                            image: appStoreArticles[0].image,
                            content: appStoreArticles[0].content,
                            isShowContent: .constant(false))
            
            ArticleCardView(category: appStoreArticles[0].category,
                            headline: appStoreArticles[0].headline,
                            subHeadline: appStoreArticles[0].subHeadline,
                            image: appStoreArticles[0].image,
                            content: appStoreArticles[0].content,
                            isShowContent: .constant(true))
            
            ArticleCardView(category: appStoreArticles[1].category,
                            headline: appStoreArticles[1].headline,
                            subHeadline: appStoreArticles[1].subHeadline,
                            image: appStoreArticles[1].image,
                            content: appStoreArticles[1].content,
                            isShowContent: .constant(true))
        }
    }
}
