/**
 `CategoryView`

 A SwiftUI view to select a category from a list.

 - Author: Omkar Nikhal
 - Date: 11/21/23
 */
import SwiftUI

struct CategoryView: View {
    
    /// Binding for the selected category.
    @Binding var categoryType: String
    
    /// Initializes a `CategoryView` with the provided binding for the selected category.
    /// - Parameter categoryType: Binding for the selected category.
    init(_ categoryType: Binding<String>) {
        self._categoryType = categoryType
    }
    
    var body: some View {
        // Main content of the CategoryView
        HStack {
            Text(Self.categoryLabel)
            
            // Picker for selecting a category
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

// MARK: - CategoryView Constants
extension CategoryView {
    static let categoryNames = ["All", "Art", "Baby", "Books", "Clothing,Shoes & Accesories", "Computers/Tablets & Networking", "Health & Beauty", "Music", "Video Games & Consoles"]
    static let categoryLabel = "Category"
    static let conditionLabel = "Condition"
    static let pickerViewVerticalPadding = 3.0
}
