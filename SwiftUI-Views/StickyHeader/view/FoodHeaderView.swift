//
//  FoodHeaderView.swift
//  SwiftUI-Views
//
//  Created by jimmy on 2022/3/29.
//

import SwiftUI

struct FoodHeaderView: View {
    @EnvironmentObject var homedata: FoodViewModel
    @Environment(\.colorScheme) var scheme
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            HStack(spacing:0) {
                Button {
                    
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.system(size: 20, weight: .bold))
                        .frame(width: getSize(), height: getSize())
                        .foregroundColor(.primary)
                }
                Text("Backery")
                    .font(.title)
                    .fontWeight(.bold)

            }
            
            ZStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Asiatisch . Kreanisch . Japnisch")
                        .font(.caption)
                    
                    HStack(spacing:8) {
                        Image(systemName: "clock")
                            .font(.caption)
                        
                        Text("30-40 Min")
                            .font(.caption)
                        
                        Text("4.3")
                            .font(.caption)
                        
                        Image(systemName: "star.fill")
                            .font(.caption)
                        
                        Text("$6.40 Fee")
                            .font(.caption)
                            .padding(.leading, 10)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                }
                .opacity(homedata.offset > 200 ? 1 - Double((homedata.offset - 200) / 50) : 1)
                
                //custom scrollview
                //for automatically scrolling
                ScrollViewReader { reader in
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 0) {
                            ForEach(tabItems) {tab in
                                Text(tab.tab)
                                    .font(.caption)
                                    .padding(.vertical, 10)
                                    .padding(.horizontal)
                                    .background(Color.primary
                                        .opacity(homedata.selectedtab == tab.tab ? 1 : 0)
                                    )
                                    .clipShape(Capsule())
                                    .foregroundColor(homedata.selectedtab == tab.tab ? (scheme == .dark ? .black : .white) : .primary)
                                    .id(tab.tab)
                            }
                            .onChange(of: homedata.selectedtab) { value in
                                withAnimation(.easeInOut) {
                                    reader.scrollTo(homedata.selectedtab, anchor: .leading)
                                }
                            }
                        }
                    }
                    //visible only when scroll up...
                    .opacity(homedata.offset > 200 ? Double((homedata.offset - 200) / 50) : 0)
                }
            }
            //default frame = 60
            //top frame = 40
            //so total = 100
            .frame(height:60)
            
            if homedata.offset > 250 {
                Divider()
            }
        }
        .padding(.horizontal)
        .frame(height:100)
        .background(scheme == .dark ? Color.black : Color.white)
    }
    
    //getting size of button and doing animation
    func getSize() -> CGFloat {
        if homedata.offset > 200 {
            let progress = (homedata.offset - 200) / 50
            if progress <= 1.0 {
                return progress * 40
            }
            return 40
        }
        return 0
    }
}

struct FoodHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        StickyHeaderContentView()
    }
}
