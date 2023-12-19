/**
 `KeywordView`

 A SwiftUI view allowing the user to enter keywords for the search.

 - Author: Omkar Nikhal
 - Date: 11/21/23
 */
import SwiftUI

struct KeywordView: View {
    
    /// Binding for the keyword input.
    @Binding var keywords: String

    /// Initializes a `KeywordView` with the provided binding for keywords.
    /// - Parameter keywords: Binding for the keyword input.
    init(_ keywords: Binding<String>) {
        self._keywords = keywords
    }
    
    var body: some View {
        // Horizontal stack for keyword input
        HStack {
            Text(Self.keywordLabel)
            
            // TextField for entering keywords
            TextField(
                Self.requiredPlaceholderText,
                text: $keywords
            )
        }
    }
}

// MARK: - KeywordView Constants
extension KeywordView {
    static let keywordLabel = "Keyword:"
    static let requiredPlaceholderText = "Required"
}
