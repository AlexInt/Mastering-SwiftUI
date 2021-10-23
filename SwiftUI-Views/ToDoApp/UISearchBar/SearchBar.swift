//
//  SearchBar.swift
//  SwiftUI-Views
//
//  Created by jimmy on 2021/10/23.
//

import SwiftUI
import Foundation

struct SearchBar: UIViewRepresentable {
    @Binding var searchText: String
    
    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar()
        
        searchBar.searchBarStyle = .minimal
        searchBar.autocapitalizationType = .none
        searchBar.placeholder = "Search.."
        searchBar.tintColor = .purple
        searchBar.delegate = context.coordinator
        
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.text = searchText
    }
    
    /*
     If you need to work with delegate in UIKit and communicate back to SwiftUI, you have to implement the makeCoordinator method and provide a Coordinator instance. This Coordinator acts as a bridge between UIView's delegate and SwiftUI.
     */

    func makeCoordinator() -> Coordinator {
        Coordinator($searchText)
    }
    
    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String
        
        init(_ text: Binding<String>) {
            self._text = text
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            searchBar.showsCancelButton = true
            text = searchText
            print("\(#function): \(text)")
        }
        
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            text = ""
            searchBar.resignFirstResponder()
            searchBar.showsCancelButton = false
            searchBar.endEditing(true)
        }
        
        func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
            searchBar.showsCancelButton = true
            
            return true
        }
        
    }
}


