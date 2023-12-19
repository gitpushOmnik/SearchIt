//
//  WishListItemsView.swift
//  CSCI571-Assi4-nikhal
//
//  Created by Omkar Nikhal on 11/23/23.
//

import SwiftUI
import Kingfisher

struct WishListItemsView: View {
    
    @ObservedObject var wishListViewModel: WishListViewModel
    
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
    static let loadingText = "Loading..."
    static let wishlistEmptyText = "No items in wishlist"
    static let totalShoppingText = "Wishlist total("
    static let itemsText = ") items:"
    static let dollarText = "$"
    static let deleteLabel = "Delete"
    static let trashFillIcon = "trash.fill"
    static let navigationTitleText = "Favorites"
}
