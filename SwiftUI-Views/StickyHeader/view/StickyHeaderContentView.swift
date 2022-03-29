//
//  StickyHeaderContentView.swift
//  SwiftUI-Views
//
//  Created by jimmy on 2022/3/29.
//

import SwiftUI

struct StickyHeaderContentView: View {
    @StateObject var homedata = FoodViewModel()
    
    //for dark mode adoption...
    @Environment(\.colorScheme) var scheme
    var body: some View {
        ScrollView {
            //since were pinning header view...
            LazyVStack(alignment: .leading, spacing: 15, pinnedViews: [.sectionHeaders]) {
                //parallax header
                GeometryReader{reader -> AnyView in
                    let offset = reader.frame(in: .global).minY
                    if -offset >= 0 {
                        DispatchQueue.main.async {
                            self.homedata.offset = -offset
                        }
                    }
                    return AnyView(
                        Image("food")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width, height: 250 + (offset > 0 ? offset : 0))
                            .cornerRadius(2)
                            .offset(y: offset > 0 ? -offset : 0)
                            .overlay(
                                HStack {
//                                    Button {
//
//                                    } label: {
//                                        Image(systemName:"arrow.left")
//                                            .font(.system(size:20, weight:.bold))
//                                            .foregroundColor(.white)
//                                    }
//
//                                    Spacer()
//
//                                    Button {
//
//                                    } label: {
//                                        Image(systemName:"suit.heart.fill")
//                                            .font(.system(size:20, weight:.bold))
//                                            .foregroundColor(.white)
//                                    }
                                }
                                    .padding(),
                                alignment:.top
                            )
                    )
                }
                .frame(height:250)
                
                
                //cards
                Section(header: FoodHeaderView()) {
                    //tabs with content...
                    ForEach(tabItems){tab in
                        VStack(alignment: .leading, spacing: 15) {
                            Text(tab.tab)
                                .font(.title2)
                                .fontWeight(.bold)
                                .padding(.bottom)
                                .padding(.leading)
                            
                            ForEach(tab.foods) {food in
                                FoodCardView(food: food)
                            }
                            Divider()
                                .padding(.top)
                        }
                        .tag(tab.tab)
                        .overlay(
                            GeometryReader {reader -> Text in
                                //calculating which tab ...
                                let offset = reader.frame(in: .global).minY
                                
                                // top area + header size 100
                                let height = UIApplication.shared.windows.first!.safeAreaInsets.top + 100
                                if offset < height &&
                                    offset > 50 &&
                                    homedata.selectedtab != tab.tab {
                                    DispatchQueue.main.async {
                                        self.homedata.selectedtab = tab.tab
                                    }
                                }
                                
                                return Text("")
                            }
                        )
                    }
                }
            }
        }
        .overlay(
            (scheme == .dark ? Color.black : Color.white)
                .frame(height:UIApplication.shared.windows.first?.safeAreaInsets.top)
                .ignoresSafeArea(.all,edges: .top)
                .opacity(homedata.offset > 250 ? 1 : 0)
            ,alignment: .top
        )
        .environmentObject(homedata)
    }
}

struct StickyHeaderContentView_Previews: PreviewProvider {
    static var previews: some View {
        StickyHeaderContentView()
            .preferredColorScheme(.dark)
            
    }
}
