//
//  ItemShippingCostView.swift
//  CSCI571-Assi4-nikhal
//
//  Created by Omkar Nikhal on 12/5/23.
//

import SwiftUI

struct ItemShippingCostView: View {
    
    @ObservedObject var itemDetailsViewModel: ItemDetailsViewModel
    var itemShippingCost: String?
    
    init(_ itemDetailsViewModel: ItemDetailsViewModel, _ itemShippingCost: String? = nil) {
        self.itemDetailsViewModel = itemDetailsViewModel
        self.itemShippingCost = itemShippingCost
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Divider()
                .frame(height: 1)
                .overlay(Color(uiColor: UIColor.lightGray))
            
            HStack {
                Image(systemName: Self.shippingLogo)
                    .font(.body)
                Text(Self.shippingText)
            }
            .padding(.top, Self.shippingTopPadding)
            .padding(.bottom, Self.shippingBottomPadding)
            
            Divider()
                .frame(height: 1)
                .overlay(Color(uiColor: UIColor.lightGray))
            
            VStack(spacing: 6) {
                if let shippingCost = itemShippingCost {
                    HStack {
                        Text(Self.shippingCostText)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity)
                        
                        Text(shippingCost == Self.freeShippingCapitalized ? Self.freeShippingText : shippingCost.replacingOccurrences(of: Self.dollarText, with: ""))
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity)
                    }
                }
                
                if let globalShipping = itemDetailsViewModel.currentItem?.itemGlobalShipping {
                    
                    HStack {
                        Text(Self.globalShippingText)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity)
                        
                        Text(globalShipping ? Self.yesText : Self.noText)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity)
                    }
                }
                
                if let handlingTime = itemDetailsViewModel.currentItem?.itemHandlingTime {
                    HStack {
                        Text(Self.handlingTimeText)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity)
                        
                        Text(String(handlingTime) + (handlingTime <= 1 ? Self.dayText : Self.daysText))
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity)
                    }
                    .padding(.bottom, Self.handlingBottomPadding)
                }
            }
            .padding(.vertical, Self.itemShippingCostViewVerticalPadding)
        }
    }
}

extension ItemShippingCostView {
    static let shippingLogo = "sailboat"
    static let shippingText = "Shipping Info"
    static let shippingCostText = "Shipping Cost"
    static let freeShippingText = "FREE"
    static let freeShippingCapitalized = "FREE SHIPPING"
    static let feedbackScoreText = "Feedback Score"
    static let popularityText = "Popularity"
    static let dollarText = "$"
    static let globalShippingText = "Global Shipping"
    static let yesText = "Yes"
    static let noText = "No"
    static let handlingTimeText = "Handling Time"
    static let dayText = " day"
    static let daysText = " days"
    static let shippingTopPadding = 10.0
    static let shippingBottomPadding = 15.0
    static let popularityBottomPadding = 8.0
    static let storeDetailsPadding = 9.0
    static let handlingBottomPadding = 8.0
    static let itemShippingCostViewVerticalPadding = 9.0
}
