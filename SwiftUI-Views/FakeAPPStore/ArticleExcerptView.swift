//
//  ArticleExcerptView.swift
//  SwiftUI-Views
//
//  Created by jimmy on 2021/11/14.
//

import SwiftUI

struct ArticleExcerptView: View {
    let category: String
    let headline: String
    let subHeadline: String
    
    @Binding var isShowContent: Bool
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            
            Rectangle()
                .frame(minHeight: 100, maxHeight: 150)
                .overlay(
                    HStack {
                        VStack(alignment: .leading) {
                            Text(self.category.uppercased())
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .foregroundColor(.secondary)
                            
                            Text(self.headline)
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                                .minimumScaleFactor(0.1)
                                .lineLimit(2)
                                .padding(.bottom, 5)
                            
                            if !self.isShowContent {
                                Text(self.subHeadline)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                    .minimumScaleFactor(0.1)
                                    .lineLimit(3)
                            }
                        }
                        .padding()
                        
                        Spacer()
                    }
                )
        }
        .foregroundColor(.white)
    }
}

struct ArticleExcerptView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ArticleExcerptView(category: appStoreArticles[0].category,
                               headline: appStoreArticles[0].headline,
                               subHeadline: appStoreArticles[0].subHeadline,
                               isShowContent : .constant(false)).previewLayout(.fixed(width: 380, height: 500))

            ArticleExcerptView(category: appStoreArticles[0].category,
                               headline: appStoreArticles[0].headline,
                               subHeadline: appStoreArticles[0].subHeadline,
                               isShowContent : .constant(true)).previewLayout(.fixed(width: 380, height: 500))
        }
        
    }
}
