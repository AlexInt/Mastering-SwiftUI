//
//  SettingView.swift
//  SwiftUI-Views
//
//  Created by jimmy on 2021/10/4.
//

import SwiftUI

struct SettingView: View {
    private var displayOrders = [ "Alphabetical",
                                  "Show Favorite First",
                                  "Show Check-i n First"]
    @State private var selectedOrder = 0
    
    @State private var showCheckInOnly = false
    
    @State private var maxPriceLevel = 5
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Sort Preference")) {
//                    Picker(selection: $selectedOrder,
//                           label: Text("Display Order")) {
//
//                    }
                    Picker("Display Order", selection: $selectedOrder) {
                        ForEach(0..<displayOrders.count, id:\.self) {
                            Text(self.displayOrders[$0])
                        }
                    }
                }
                
                Section(header: Text("Filter Preference")) {
//                    Toggle(isOn: $showCheckInOnly) {
//                        Text("Show Check-in only")
//                    }
                    Toggle("Show Check-in only", isOn: $showCheckInOnly)
                    
                    Stepper("Show\(String(repeating: "$", count: maxPriceLevel)) or below") {
                        self.maxPriceLevel += 1
                        
                        if self.maxPriceLevel > 5 {
                            self.maxPriceLevel = 5
                        }
                    } onDecrement: {
                        self.maxPriceLevel -= 1
                        
                        if self.maxPriceLevel < 1 {
                            self.maxPriceLevel = 1
                        }
                    }

                }
            }
            .navigationBarTitle(Text("Settings"))
            
            .navigationBarItems(leading:
                
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Cancel")
                        .foregroundColor(.black)
                })
                
                , trailing:

                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Save")
                        .foregroundColor(.black)
                })
            )
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
