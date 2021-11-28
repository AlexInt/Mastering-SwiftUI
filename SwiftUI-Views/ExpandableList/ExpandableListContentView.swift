//
//  ExpandableListContentView.swift
//  SwiftUI-Views
//
//  Created by jimmy on 2021/11/28.
//

import SwiftUI

struct ExpandableListContentView: View {
    var body: some View {
        List{
            ForEach(sampleMenuItems) { menuItem in
                
                Section(header:
                   HStack{
                    
                        Text(menuItem.name)
                            .font(.title3)
                            .fontWeight(.heavy)
                    
                        Image(menuItem.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                    }
                    .padding(.vertical)
                        
                ) {
                    OutlineGroup(sampleMenuItems, children: \.subMenuItems) { item in
                        HStack {
                            Image(item.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                            
                            Text(item.name)
                                .font(.system(.title3, design: .rounded))
                                .bold()
                        }
                    }
                }
            }
            
        }
//                .listStyle(InsetGroupedListStyle())
    }
}

struct ExpandableListContentView_Previews: PreviewProvider {
    static var previews: some View {
//        ExpandableListContentView()
//        DisC()
        FaqView(showContent: true)
    }
}

struct FaqView: View {
    @State var showContent = true
    var body: some View {
        VStack {
            DisclosureGroup(
                content: {
                    Text("Absolutely! You are allowed to reuse the source code in your own pro jects (personal/commercial). However, you're not allowed to distribute or sell thesource code without prior authorization.")
                        .font(.body)
                        .fontWeight(.light)
                }, label: {
                    
                    Text("1. Can I reuse the source code?")
                        .font(.body)
                        .bold()
                        .foregroundColor(.yellow)
                }
            )

            
            DisclosureGroup("1. Can I reuse the source code?", isExpanded: $showContent) {
                Text("Absolutely! You are allowed to reuse the source code in your own pro jects (personal/commercial). However, you're not allowed to distribute or sell thesource code without prior authorization.")
                    .font(.body)
                    .fontWeight(.light)
            }
            
            DisclosureGroup(isExpanded: $showContent) {
                Text("Absolutely! You are allowed to reuse the source code in your own pro jects (personal/commercial). However, you're not allowed to distribute or sell thesource code without prior authorization.")
                    .font(.body)
                    .fontWeight(.light)
            } label: {
                Text("1. Can I reuse the source code?")
                    .font(.body)
                    .bold()
                    .foregroundColor(showContent ? .primary : .red)
            }
            
        }
        
        .padding()
    }
}
