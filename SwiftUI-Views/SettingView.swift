//
//  SettingView.swift
//  SwiftUI-Views
//
//  Created by jimmy on 2021/10/4.
//

import SwiftUI
import Combine

struct SettingView: View {

    @State private var selectedOrder: DisplayOrderType = .alphabetical
    
    @State private var showCheckInOnly = false
    
    @State private var maxPriceLevel = 5
    
    @EnvironmentObject var settingStore: SettingStore
    
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
                        ForEach(DisplayOrderType.allCases, id:\.self) {
                            Text($0.text)
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
                self.settingStore.showCheckInOnly = self.showCheckInOnly;
                self.settingStore.displayOrder = self.selectedOrder;
                self.settingStore.maxPriceLevel = self.maxPriceLevel;
                self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Save")
                        .foregroundColor(.black)
                })
            )
        }
        .onAppear {
            self.selectedOrder = self.settingStore.displayOrder
            self.showCheckInOnly = self.settingStore.showCheckInOnly
            self.maxPriceLevel = self.settingStore.maxPriceLevel
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView().environmentObject(SettingStore())
    }
}
