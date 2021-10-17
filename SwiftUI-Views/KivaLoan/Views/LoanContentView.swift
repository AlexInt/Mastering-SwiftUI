//
//  LoanContentView.swift
//  SwiftUI-Views
//
//  Created by jimmy on 2021/10/17.
//

import SwiftUI

struct LoanContentView: View {
    
    @ObservedObject var loanStore = LoanStore()
    
    // stores the current state of the filter view
    @State private var filterEnabled = false
    //stores the maximum loan amount for display
    @State private var maximumLoanAmount = 10000.0
    
    var body: some View {
        NavigationView {
            if self.filterEnabled {
                LoanFilterView(amount: self.$maximumLoanAmount)
                    .transition(.opacity)
            }
            
            List(loanStore.loans) { loan in
                LoanCellView(loan: loan)
                    .padding(.vertical, 5)
            }
            .navigationBarTitle("Kiva Loan")
            .navigationBarItems(trailing:                                    Button(action: {
                            withAnimation(.linear) {
                                    self.filterEnabled.toggle()
                                    self.loanStore.filterLoans(maxAmount: Int(self.maximumLoanAmount))
                            }
                        }, label: {
                            Text("Filter")
                                .font(.subheadline)
                                .foregroundColor(.primary)
                        })
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {
            self.loanStore.fetchLatestLoans()
        }
        
    }
}

struct LoanContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoanContentView()
    }
}
