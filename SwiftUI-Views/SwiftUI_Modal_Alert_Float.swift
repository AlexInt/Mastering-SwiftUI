//
//  SwiftUI_Modal_Alert_Float.swift
//  SwiftUI-Views
//
//  Created by jimmy on 2021/10/4.
//

import SwiftUI

struct SwiftUI_Modal_Alert_Float: View {
    
    @State var showDetailView = false
    @State var selectedArticle: ArticleDetail?
    
    var body: some View {
        NavigationView {
            List(DetailArticles) { article in
                ArticleDetailRow(article: article)
                    .onTapGesture {
                        self.showDetailView = true
                        self.selectedArticle = article
                    }
            }
            //We can show Modal based on boolean.
//            .sheet(isPresented: $showDetailView) {
//                ArticleDetailView(article: DetailArticles[0])
//            }
            
            //It is also bindable with Identifiable item.
//            .sheet(item: $selectedArticle, content: { article in
//                ArticleDetailView(article: article)
//            })
            .fullScreenCover(item: $selectedArticle, content: { article in
                ArticleDetailView(article: article)
            })
            
            .navigationBarTitle("Your Reading")
        }
        .navigationViewStyle(StackNavigationViewStyle()) //adapt for ipad
        
    }
}

struct SwiftUI_Modal_Alert_Float_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUI_Modal_Alert_Float()
    }
}
