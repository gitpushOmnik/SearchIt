/**
 `SearchResultItemsView`

 A SwiftUI view displaying search results, including item details and an option to add/remove items from the wish list.

 - Author: Omkar Nikhal
 - Date: 11/22/23
 */
import SwiftUI
import Kingfisher

struct SearchResultItemsView: View {
    
    /// The view model for search results.
    @ObservedObject var searchResultsViewModel: SearchResultsViewModel
    
    /// The view model for wish list items.
    @ObservedObject var wishListViewModel: WishListViewModel
    
    /// The view model for item details.
    @ObservedObject var itemDetailsViewModel: ItemDetailsViewModel
    
    /**
     Initializes a `SearchResultItemsView` with the required view models.

     - Parameters:
        - searchResultsViewModel: The view model for search results.
        - wishListViewModel: The view model for wish list items.
        - itemDetailsViewModel: The view model for item details.
     */
    init(_ searchResultsViewModel: SearchResultsViewModel, _ wishListViewModel: WishListViewModel, _ itemDetailsViewModel: ItemDetailsViewModel) {
        self.searchResultsViewModel = searchResultsViewModel
        self.wishListViewModel = wishListViewModel
        self.itemDetailsViewModel = itemDetailsViewModel
    }
    
    var body: some View {
        Section {
            List {
                Text(Self.resultsText)
                    .font(.title)
                    .bold()
                    .padding(.vertical, Self.resultsTextVerticalPadding)
                
                if searchResultsViewModel.isSearchResultsLoading {
                    VStack(alignment: .center) {
                        ActivityProgressView(isAnimating: .constant(true), style: .medium)
                        
                        Text(Self.loadingText)
                            .foregroundStyle(Color.gray)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, Self.loadingTextVerticalPadding)
                } else {
                    if searchResultsViewModel.searchResultItems.count > 0 {
                        ForEach(searchResultsViewModel.searchResultItems, id: \.itemID) { searchResultItem in
                            
                            NavigationLink(destination: ItemDetailsView(itemDetailsViewModel: itemDetailsViewModel,
                                                                        wishListViewModel: wishListViewModel,
                                                                        itemID: searchResultItem.itemID ?? "",
                                                                        itemShippingCost: searchResultsViewModel.shippingCostMapping[searchResultItem.itemID] ?? "")) {
                                HStack {
                                    ItemView(searchResultItem: searchResultItem, wishListItem: nil)
                                    
                                    Image(systemName: wishListViewModel.wishListItemIDs.contains(searchResultItem.itemID ?? "")  ? Self.heartFillImage : Self.heartImage)
                                        .font(.title)
                                        .foregroundStyle(Color.red)
                                        .onTapGesture {
                                            if wishListViewModel.wishListItemIDs.contains(searchResultItem.itemID ?? "") {
                                                wishListViewModel.removeFromWishListItems(searchResultItem.itemID ?? "", true)
                                            } else {
                                                wishListViewModel.addWishListItems(searchResultItem.itemID ?? "", true)
                                            }
                                        }
                                }
                                .padding(.vertical, Self.listItemVerticalPadding)
                            }
                        }
                    } else {
                        Text(Self.noResultsText)
                            .foregroundStyle(Color.red)
                    }
                }
            }
        }
    }
}

extension SearchResultItemsView {
    /// The text for the "Results" section.
    static let resultsText = "Results"
    
    /// The text displayed while search results are loading.
    static let loadingText = "Please wait..."
    
    /// The image name for a filled heart (indicating an item is in the wish list).
    static let heartFillImage = "heart.fill"
    
    /// The image name for an outline heart (indicating an item is not in the wish list).
    static let heartImage = "heart"
    
    /// The text displayed when no search results are found.
    static let noResultsText = "No results found."
    
    /// The vertical padding for the "Results" text.
    static let resultsTextVerticalPadding = 5.0
    
    /// The vertical padding for the loading text.
    static let loadingTextVerticalPadding = 5.0
    
    /// The vertical padding for each list item.
    static let listItemVerticalPadding = 3.0
}
