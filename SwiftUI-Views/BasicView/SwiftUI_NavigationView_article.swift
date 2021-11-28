//
//  SwiftUI_NavigationView_article.swift
//  SwiftUI-Views
//
//  Created by jimmy on 2021/10/3.
//

import SwiftUI

struct SwiftUI_NavigationView_article: View {
    
    init() {
        // Set selected (onTapped) background color of cell.
        let color = UIView()
        color.backgroundColor = UIColor.red
        UITableViewCell.appearance().selectedBackgroundView = color
    }
    
    var body: some View {
        
        NavigationView {
            List(DetailArticles) { article in
                ZStack {
                    ArticleDetailRow(article: article)
                    NavigationLink(destination: ArticleDetailView(article: article)) {
                        EmptyView()
                    }
                }
            }
            .navigationBarTitle("Your Reading")
        }
    }
}

struct SwiftUI_NavigationView_article_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUI_NavigationView_article()
    }
}


struct ArticleDetailRow: View {
    var article: ArticleDetail
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(article.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(5)
            
            Text(article.title)
                .font(.system(.title, design: .rounded))
                .fontWeight(.black)
                .lineLimit(3)
                .padding(.bottom, 0)
            
            Text("By \(article.author)".uppercased())
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.bottom, 0)
            
            HStack(spacing: 3) {
                ForEach(1...(article.rating), id: \.self) { _ in
                    Image(systemName: "star.fill")
                        .font(.caption)
                        .foregroundColor(.yellow)
                }
            }
            
            Text(article.excerpt)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
        }
    }
}
