//
//  ToDoSearchBar.swift
//  SwiftUI-Views
//
//  Created by jimmy on 2021/11/2.
//

import SwiftUI

struct ToDoSearchBar: View {
    
    @Binding var text: String
    @State private var isEditing = false

    //with closures that read and write the binding value
    private var searchText: Binding<String> {
        Binding<String>(
            get: {
                self.text.capitalized
            }
            ,set: {
                self.text = $0
            }
        )
    }
    
    var body: some View {
        HStack {
            TextField("Search ...", text: searchText)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth:0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                        if isEditing {
                            Button {
                                self.text = ""
                            } label: {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .padding(.horizontal, 10)
                .onTapGesture {
                    self.isEditing = true
                }
            
            if isEditing {
                Button {
                    self.isEditing = false
                    self.text = ""
                    
                    //dismiss the keyboard
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                } label: {
                    Text("Cancel")
                }
                .padding()
                .transition(.move(edge: .trailing))
                .animation(.default)

            }
        }
    }
}

struct ToDoSearchBar_Previews: PreviewProvider {
    static var previews: some View {
        ToDoSearchBar(text: .constant(""))
    }
}


