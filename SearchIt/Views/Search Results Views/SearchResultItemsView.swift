//
//  SearchResultItemsView.swift
//  CSCI571-Assi4-nikhal
//
//  Created by Omkar Nikhal on 11/22/23.
//

import SwiftUI
import Kingfisher

struct SearchResultItemsView: View {
    
    @ObservedObject var searchResultsViewModel: SearchResultsViewModel
    @ObservedObject var wishListViewModel: WishListViewModel
    @ObservedObject var itemDetailsViewModel: ItemDetailsViewModel
    
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
    static let resultsText = "Results"
    static let loadingText = "Please wait..."
    static let heartFillImage = "heart.fill"
    static let heartImage = "heart"
    static let noResultsText = "No results found."
    static let resultsTextVerticalPadding = 5.0
    static let loadingTextVerticalPadding = 5.0
    static let listItemVerticalPadding = 3.0
}
