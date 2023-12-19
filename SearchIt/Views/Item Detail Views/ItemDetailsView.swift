//
//  ItemDetailsView.swift
//  CSCI571-Assi4-nikhal
//
//  Created by Omkar Nikhal on 11/23/23.
//

import SwiftUI

struct ItemDetailsView: View {
    
    @ObservedObject var itemDetailsViewModel: ItemDetailsViewModel
    @ObservedObject var wishListViewModel: WishListViewModel
    
    var itemID: String
    var itemShippingCost: String?
    
    var body: some View {
        TabView {
            if itemDetailsViewModel.isItemDetailsLoading {
                ProgressView()
                    .tabItem {
                        Label(Self.infoText, systemImage: Self.infoLogo)
                    }
            } else {
                ItemInfoView(itemDetailsViewModel: itemDetailsViewModel)
                    .tabItem {
                        Label(Self.infoText, systemImage: Self.infoLogo)
                    }
            }
            
            ItemShippingView(itemDetailsViewModel: itemDetailsViewModel, itemShippingCost: itemShippingCost)
                .tabItem {
                    Label(Self.shippingText, systemImage: Self.shippingLogo)
                }
                
            
            ItemPhotosView(itemDetailsViewModel: itemDetailsViewModel)
                .tabItem {
                    Label(Self.photosText, systemImage: Self.photosLogo)
                }
            
            SimilarItemsView(itemDetailsViewModel: itemDetailsViewModel)
                .tabItem {
                    Label(Self.similarText, systemImage: Self.similarLogo)
                }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                
                HStack {
                    Spacer()
                    
                    Link(destination: URL(string: Self.facebookURLString+(itemDetailsViewModel.currentItem?.itemURL ?? ""))!, label: {
                        Image(Self.facebookImage)
                            .resizable()
                            .scaledToFit()
                            .frame(height: Self.facebookImageHeight)
                    })
                    
                    Button(action: {
                        if wishListViewModel.wishListItemIDs.contains(itemDetailsViewModel.currentItem?.itemID ?? "") {
                            wishListViewModel.removeFromWishListItems(itemDetailsViewModel.currentItem?.itemID ?? "", false)
                        } else {
                            wishListViewModel.addWishListItems(itemDetailsViewModel.currentItem?.itemID ?? "", false)
                        }
                    }, label: {
                        Image(systemName: wishListViewModel.wishListItemIDs.contains(itemDetailsViewModel.currentItem?.itemID ?? "")  ? Self.heartFillImage : Self.heartImage)
                            .foregroundStyle(Color.red)
                    })
                    
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear{
            itemDetailsViewModel.getItemDetails(itemID)
        }
    }
}

extension ItemDetailsView {
    static let infoText = "Info"
    static let infoLogo = "info.circle"
    static let shippingText = "Shipping"
    static let shippingLogo = "shippingbox.fill"
    static let photosText = "Photos"
    static let photosLogo = "photo.stack"
    static let similarText = "Similar"
    static let similarLogo = "list.bullet.indent"
    static let facebookURLString = "https://www.facebook.com/sharer/sharer.php?u="
    static let facebookImage = "fb"
    static let heartFillImage = "heart.fill"
    static let heartImage = "heart"
    static let facebookImageHeight = 25.0
}
