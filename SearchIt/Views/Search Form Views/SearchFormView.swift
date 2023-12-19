//
//  ContentView.swift
//  CSCI571-Assi4-nikhal
//
//  Created by Omkar Nikhal on 11/19/23.
//

import SwiftUI

struct SearchFormView: View {
    
    @StateObject private var searchFormViewModel = SearchFormViewModel(searchForm: SearchForm(), 
                                                                       toast: Toast())
    @StateObject private var searchResultsViewModel = SearchResultsViewModel()
    @StateObject private var wishListViewModel = WishListViewModel()
    @StateObject private var itemDetailsViewModel = ItemDetailsViewModel()
    
    var body: some View {
        NavigationStack {
            Form {
                
                KeywordView($searchFormViewModel.searchForm.keywords)
                
                CategoryView($searchFormViewModel.searchForm.categoryType)
                
                ConditionView($searchFormViewModel.searchForm.newCondition,
                              $searchFormViewModel.searchForm.usedCondition,
                              $searchFormViewModel.searchForm.unspecifiedCondition)
                
                ShippingView($searchFormViewModel.searchForm.localShipping,
                             $searchFormViewModel.searchForm.freeShipping)
                
                DistanceView($searchFormViewModel.searchForm.distance)
                
                CustomLocationView(searchFormViewModel)
                
                FormButtonsView(searchFormViewModel, searchResultsViewModel)
                
                if searchFormViewModel.searchForm.isFormValid {
                    SearchResultItemsView(searchResultsViewModel, wishListViewModel, itemDetailsViewModel)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        WishListItemsView(wishListViewModel)
                    } label: {
                        Image(systemName: Self.heartCircleImage)
                    }
                }
            }
            .navigationTitle(Self.navigationTitleText)
        }
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
        .onAppear(perform: {
            searchFormViewModel.fetchCurrentLocation()
        })
    }
}

extension SearchFormView {
    static let navigationTitleText = "SearchIt"
    static let heartCircleImage = "heart.circle"
    static let addedToast = "Added to favorites"
    static let removedToast = "Removed from favorites"
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SearchFormView()
    }
}
