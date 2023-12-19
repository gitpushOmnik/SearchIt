//
//  ItemSellerView.swift
//  CSCI571-Assi4-nikhal
//
//  Created by Omkar Nikhal on 12/5/23.
//

import SwiftUI

struct ItemSellerView: View {
    @ObservedObject var itemDetailsViewModel: ItemDetailsViewModel

    init(_ itemDetailsViewModel: ItemDetailsViewModel) {
        self.itemDetailsViewModel = itemDetailsViewModel
    }
    
    var body: some View {
        if itemDetailsViewModel.currentItem?.itemStoreURL != nil || 
            itemDetailsViewModel.currentItem?.itemFeedbackScore != nil ||
            itemDetailsViewModel.currentItem?.itemFeedbackPercent != nil {
            VStack(alignment: .leading, spacing: 0) {
                Divider()
                    .frame(height: 1)
                    .overlay(Color(uiColor: UIColor.lightGray))
                
                HStack {
                    Image(systemName: Self.storeLogo)
                        .font(.body)
                    Text(Self.sellerText)
                        .font(.body)
                }
                .padding(.top, Self.storeTopPadding)
                .padding(.bottom, Self.storeBottomPadding)
                
                Divider()
                    .frame(height: 1)
                    .overlay(Color(uiColor: UIColor.lightGray))
                
                VStack(spacing: 6) {
                    
                    if let storeName = itemDetailsViewModel.currentItem?.itemStoreName, let storeURL = itemDetailsViewModel.currentItem?.itemStoreURL {
                        HStack {
                            Text(Self.storeNameText)
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity)
                            
                            Link(storeName, destination: URL(string: storeURL)!)
                                .foregroundStyle(.blue)
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity)
                        }
                    }
                    
                    if let feedbackScore = itemDetailsViewModel.currentItem?.itemFeedbackScore {
                        HStack {
                            Text(Self.feedbackScoreText)
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity)
                            
                            Text(String(feedbackScore))
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity)
                        }
                    }
                    
                    if let feedbackPercent = itemDetailsViewModel.currentItem?.itemFeedbackPercent {
                        
                        HStack {
                            Text(Self.popularityText)
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity)
                            
                            Text(String(feedbackPercent))
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity)
                        }
                        .padding(.bottom, Self.popularityBottomPadding)
                    }
                }
                .padding(.vertical, Self.storeDetailsPadding)
            }
        }
    }
}

extension ItemSellerView {
    static let storeLogo = "storefront"
    static let sellerText = "Seller"
    static let storeNameText = "Store Name"
    static let feedbackScoreText = "Feedback Score"
    static let popularityText = "Popularity"
    static let storeTopPadding = 11.0
    static let storeBottomPadding = 17.0
    static let popularityBottomPadding = 8.0
    static let storeDetailsPadding = 9.0
}
