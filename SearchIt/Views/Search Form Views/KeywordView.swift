//
//  KeywordView.swift
//  CSCI571-Assi4-nikhal
//
//  Created by Omkar Nikhal on 11/21/23.
//

import SwiftUI

struct KeywordView: View {
    
    @Binding var keywords: String

    init(_ keywords: Binding<String>) {
        self._keywords = keywords
    }
    
    var body: some View {
        HStack {
           Text(Self.keywordLabel)
           
           TextField(
               Self.requiredPlaceholderText,
               text: $keywords
           )
       }
    }
}

extension KeywordView {
    static let keywordLabel = "Keyword:"
    static let requiredPlaceholderText = "Required"
}
