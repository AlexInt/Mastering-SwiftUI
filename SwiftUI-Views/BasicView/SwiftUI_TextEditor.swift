//
//  SwiftUI_TextEditor.swift
//  SwiftUI-Views
//
//  Created by jimmy on 2021/11/28.
//

import SwiftUI
/*
 In iOS 14, Apple introduced a new component called TextEditor for the SwiftUI framework. This TextEditor enables developers to display and edit multiline text in your apps.
 */

struct SwiftUI_TextEditor: View {
    @State private var inputText = ""
    @State private var wordCount: Int = 0
    
    var body: some View {
//        TextEditor(text: $inputText)
//            .font(.title)
//            .lineSpacing(20)
//            .autocapitalization(.words)
//            .disableAutocorrection(true)
//            .padding()
        
        ZStack(alignment: .topTrailing) {
            TextEditor(text: $inputText)
                .font(.body)
                .padding()
                .padding(.top, 20)
                .frame(height: 300)
                .background(Color.secondary)
            //Using the onChange() Modifier to Detect Text Input Change
                .onChange(of: inputText) { value in
                    let words = inputText.split { $0 == " " || $0.isNewline }
                    self.wordCount = words.count
                }
            
            Text("\(wordCount) words")
                .font(.headline)
                .foregroundColor(.secondary)
                .padding(.trailing)
        }
    }
}

struct SwiftUI_TextEditor_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUI_TextEditor()
    }
}
