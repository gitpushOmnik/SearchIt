/**
 `FormButtonsView`

 A SwiftUI view containing submit and clear buttons for the search form.

 - Author: Omkar Nikhal
 - Date: 11/21/23
 */
import SwiftUI

struct FormButtonsView: View {
    
    /// Observed object for the search form view model.
    @ObservedObject var searchFormViewModel: SearchFormViewModel
    
    /// Observed object for the search results view model.
    @ObservedObject var searchResultsViewModel: SearchResultsViewModel
    
    /// Initializes a `FormButtonsView` with the provided search form and search results view models.
    /// - Parameters:
    ///   - searchFormViewModel: Observed object for the search form view model.
    ///   - searchResultsViewModel: Observed object for the search results view model.
    init(_ searchFormViewModel: SearchFormViewModel, _ searchResultsViewModel: SearchResultsViewModel) {
        self.searchFormViewModel = searchFormViewModel
        self.searchResultsViewModel = searchResultsViewModel
    }
    
    var body: some View {
        // Horizontal stack for buttons
        HStack {
            Spacer()
            
            // Submit button
            Button(action: {
                // Validate search form and get search results
                if searchFormViewModel.validateSearchForm() {
                    let searchQueryString = searchFormViewModel.generateSearchResultsQuery()
                    searchResultsViewModel.getSearchResultItems(searchQueryString)
                }
            }){
                Text(Self.submitLabel)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: Self.buttonWidth, height: Self.buttonHeight)
            }
            .buttonStyle(.borderless)
            .background(Color.blue)
            .cornerRadius(Self.buttonCornerRadius)
            
            Spacer()
            
            // Clear button
            Button(action: {
                // Clear search form and search results
                searchFormViewModel.clearForm()
                searchResultsViewModel.clearSearchResults()
            }){
                Text(Self.clearLabel)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: Self.buttonWidth, height: Self.buttonHeight)
            }
            .buttonStyle(.plain)
            .background(Color.blue)
            .cornerRadius(Self.buttonCornerRadius)
            
            Spacer()
        }
    }
}

// MARK: - FormButtonsView Constants
extension FormButtonsView {
    static let submitLabel = "Submit"
    static let clearLabel = "Clear"
    static let buttonWidth = 110.0
    static let buttonHeight = 55.0
    static let buttonCornerRadius = 10.0
}
