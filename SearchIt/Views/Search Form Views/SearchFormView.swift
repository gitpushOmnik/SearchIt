/**
 `SearchFormView`

 The main view for the search form, allowing users to input search criteria and view search results.

 - Author: Omkar Nikhal
 - Date: 11/19/23
 */
import SwiftUI

struct SearchFormView: View {
    
    /// The view model for the search form.
    @StateObject private var searchFormViewModel = SearchFormViewModel(searchForm: SearchForm(), toast: Toast())
    
    /// The view model for search results.
    @StateObject private var searchResultsViewModel = SearchResultsViewModel()
    
    /// The view model for the wishlist.
    @StateObject private var wishListViewModel = WishListViewModel()
    
    /// The view model for item details.
    @StateObject private var itemDetailsViewModel = ItemDetailsViewModel()
    
    /// The body of the search form view.
    var body: some View {
        // Navigation stack for handling navigation within the app
        NavigationStack {
            // Form containing search input fields
            Form {
                
                // Keyword input view
                KeywordView($searchFormViewModel.searchForm.keywords)
                
                // Category selection view
                CategoryView($searchFormViewModel.searchForm.categoryType)
                
                // Condition selection view
                ConditionView($searchFormViewModel.searchForm.newCondition,
                              $searchFormViewModel.searchForm.usedCondition,
                              $searchFormViewModel.searchForm.unspecifiedCondition)
                
                // Shipping options view
                ShippingView($searchFormViewModel.searchForm.localShipping,
                             $searchFormViewModel.searchForm.freeShipping)
                
                // Distance input view
                DistanceView($searchFormViewModel.searchForm.distance)
                
                // Custom location input view
                CustomLocationView(searchFormViewModel)
                
                // Buttons for submitting and clearing the form
                FormButtonsView(searchFormViewModel, searchResultsViewModel)
                
                // Display search results if the form is valid
                if searchFormViewModel.searchForm.isFormValid {
                    SearchResultItemsView(searchResultsViewModel, wishListViewModel, itemDetailsViewModel)
                }
            }
            // Toolbar with a button to navigate to the wishlist
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        WishListItemsView(wishListViewModel)
                    } label: {
                        Image(systemName: Self.heartCircleImage)
                    }
                }
            }
            // Navigation title for the view
            .navigationTitle(Self.navigationTitleText)
        }
        // Show toast messages for various events
        .showToast($searchFormViewModel.toast.showToast) {
            Text(searchFormViewModel.toast.toastString)
                .foregroundColor(.white)
        }
        .showToast($wishListViewModel.addedToWishList) {
            Text(Self.addedToast)
                .foregroundColor(.white)
        }
        .showToast($wishListViewModel.removedFromWishList) {
            Text(Self.removedToast)
                .foregroundColor(.white)
        }
        // Fetch the user's current location when the view appears
        .onAppear(perform: {
            searchFormViewModel.fetchCurrentLocation()
        })
    }
}

// MARK: - SearchFormView Constants
extension SearchFormView {
    static let navigationTitleText = "SearchIt"
    static let heartCircleImage = "heart.circle"
    static let addedToast = "Added to favorites"
    static let removedToast = "Removed from favorites"
}

// MARK: - ContentView_Previews
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SearchFormView()
    }
}
