//
//  ItemView.swift
//  CSCI571-Assi4-nikhal
//
//  Created by Omkar Nikhal on 12/5/23.
//

import SwiftUI
import Kingfisher

struct ItemView: View {
    
    var searchResultItem: SearchResultItem?
    var wishListItem: WishListItem?
    
    init(searchResultItem: SearchResultItem?, wishListItem: WishListItem?) {
        self.searchResultItem = searchResultItem
        self.wishListItem = wishListItem
    }
    
    var body: some View {
        if let searchResultItem = searchResultItem {
            KFImage.url(URL(string: searchResultItem.itemImageURL ?? ""))
                .placeholder{Color.gray}
                .resizable()
                .frame(width: Self.listRowImageWidth, height: Self.listRowImageHeight)
            
            VStack(alignment: .leading, spacing: Self.listItemsSpacing) {
                Text(searchResultItem.itemTitle ?? Self.naText)
                    .font(.body)
                    .foregroundStyle(Color.black)
                    .lineLimit(1)
                
                Text(searchResultItem.itemPrice ?? Self.naText)
                    .font(.subheadline)
                    .foregroundStyle(Color.blue)
                    .fontWeight(.bold)
                
                Text(searchResultItem.itemShippingCost ?? Self.naText)
                    .font(.subheadline)
                    .foregroundStyle(Color.gray)
                
                HStack {
                    Text(searchResultItem.itemZipcode ?? Self.naText)
                        .font(.subheadline)
                        .foregroundStyle(Color.gray)
                    Spacer()
                    Text(searchResultItem.itemConditionName ?? Self.naText)
                        .font(.subheadline)
                        .foregroundStyle(Color.gray)
                }
            }
        } else if let wishListItem = wishListItem {
            KFImage.url(URL(string: wishListItem.itemImageURL ?? ""))
                .placeholder{Color.gray}
                .resizable()
                .frame(width: Self.listRowImageWidth, height: Self.listRowImageHeight)
            
            VStack(alignment: .leading, spacing: Self.listItemsSpacing) {
                Text(wishListItem.itemTitle ?? Self.naText)
                    .font(.body)
                    .foregroundStyle(Color.black)
                    .lineLimit(1)
                
                Text(wishListItem.itemPrice ?? Self.naText)
                    .font(.subheadline)
                    .foregroundStyle(Color.blue)
                    .fontWeight(.bold)
                
                Text(wishListItem.itemShippingCost ?? Self.naText)
                    .font(.subheadline)
                    .foregroundStyle(Color.gray)
                
                HStack {
                    Text(wishListItem.itemZipcode ?? Self.naText)
                        .font(.subheadline)
                        .foregroundStyle(Color.gray)
                    Spacer()
                    Text(wishListItem.itemConditionName ?? Self.naText)
                        .font(.subheadline)
                        .foregroundStyle(Color.gray)
                }
            }
        }
    }
}

extension ItemView {
    static let naText = "N/A"
    static let listRowImageHeight = 79.0
    static let listRowImageWidth = 82.0
    static let listItemsSpacing = 7.0
}
