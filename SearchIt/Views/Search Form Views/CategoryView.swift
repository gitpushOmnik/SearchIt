//
//  CategoryView.swift
//  CSCI571-Assi4-nikhal
//
//  Created by Omkar Nikhal on 11/21/23.
//

import SwiftUI

struct CategoryView: View {
    
    @Binding var categoryType: String
    
    init(_ categoryType: Binding<String>) {
        self._categoryType = categoryType
    }
    
    var body: some View {
        HStack{
            Text(Self.categoryLabel)
            
            Picker("", selection: $categoryType) {
                ForEach(Self.categoryNames, id: \.self) {
                    Text($0)
                        .tag($0)
                }
            }
            .pickerStyle(.menu)
        }
        .padding(.vertical, Self.pickerViewVerticalPadding)
    }
}

extension CategoryView {
    static let categoryNames = ["All", "Art", "Baby", "Books", "Clothing,Shoes & Accesories", "Computers/Tablets & Networking", "Health & Beauty", "Music", "Video Games & Consoles"]
    static let categoryLabel = "Category"
    static let conditionLabel = "Condition"
    static let pickerViewVerticalPadding = 3.0
}

