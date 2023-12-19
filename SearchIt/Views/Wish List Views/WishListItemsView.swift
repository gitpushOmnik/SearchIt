/**
 `WishListItemsView`

 A SwiftUI view displaying items in the wish list, including total cost and swipe-to-delete functionality.

 - Author: Omkar Nikhal
 - Date: 11/23/23
 */
import SwiftUI
import Kingfisher

struct WishListItemsView: View {
    
    /// The view model for wish list items.
    @ObservedObject var wishListViewModel: WishListViewModel
    
    /**
     Initializes a `WishListItemsView` with the required view model.

     - Parameters:
        - wishListViewModel: The view model for wish list items.
     */
    init(_ wishListViewModel: WishListViewModel) {
        self.wishListViewModel = wishListViewModel
    }
    
    var body: some View {
        NavigationStack {
            if wishListViewModel.isWishListLoading {
                Text(Self.loadingText)
            } else {
                if wishListViewModel.wishListItems.count == 0 {
                    Text(Self.wishlistEmptyText)
                } else {
                    List {
                        HStack {
                            Text(Self.totalShoppingText + String(wishListViewModel.wishListItems.count) + Self.itemsText)
                            Spacer()
                            Text(Self.dollarText + String(format: "%.2f", wishListViewModel.totalShoppingCost))
                        }
                        
                        if wishListViewModel.wishListItems.count > 0 {
                            ForEach(wishListViewModel.wishListItems, id: \.itemID) { wishListItem in
                                HStack {
                                    ItemView(searchResultItem: nil, wishListItem: wishListItem)
                                }
                                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                    Button(role: .destructive) {
                                        wishListViewModel.removeFromWishListItems(wishListItem.itemID ?? "", false)
                                    } label: {
                                        Label(Self.deleteLabel, systemImage: Self.trashFillIcon)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle(Self.navigationTitleText)
        .onAppear{
            wishListViewModel.getWishListItems(WishListViewModel.getWishListURLString)
        }
    }
}

extension WishListItemsView {
    /// The text displayed while wish list items are loading.
    static let loadingText = "Loading..."
    
    /// The text displayed when the wish list is empty.
    static let wishlistEmptyText = "No items in wishlist"
    
    /// The text for the total shopping cost in the wish list.
    static let totalShoppingText = "Wishlist total("
    
    /// The text indicating the number of items in the wish list.
    static let itemsText = ") items:"
    
    /// The dollar sign text.
    static let dollarText = "$"
    
    /// The label for the delete action in swipe-to-delete.
    static let deleteLabel = "Delete"
    
    /// The system image name for the trash fill icon.
    static let trashFillIcon = "trash.fill"
    
    /// The navigation title for the wish list view.
    static let navigationTitleText = "Favorites"
}
