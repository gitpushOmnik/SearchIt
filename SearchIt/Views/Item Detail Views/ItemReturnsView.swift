//
//  ItemReturnsView.swift
//  CSCI571-Assi4-nikhal
//
//  Created by Omkar Nikhal on 12/5/23.
//

import SwiftUI

struct ItemReturnsView: View {
    
    @ObservedObject var itemDetailsViewModel: ItemDetailsViewModel
    
    init(_ itemDetailsViewModel: ItemDetailsViewModel) {
        self.itemDetailsViewModel = itemDetailsViewModel
    }
    
    var body: some View {
        if itemDetailsViewModel.currentItem?.itemReturnsAccpeted != nil || itemDetailsViewModel.currentItem?.itemRefundMode != nil || itemDetailsViewModel.currentItem?.itemRetunsWithin != nil || itemDetailsViewModel.currentItem?.itemShippingCostPaidBy != nil {
            
            VStack(alignment: .leading, spacing: 0) {
                Divider()
                    .frame(height: 1)
                    .overlay(Color(uiColor: UIColor.lightGray))
                
                HStack {
                    Image(systemName: Self.returnImage)
                        .font(.body)
                    Text(Self.returnPolicyText)
                }
                .padding(.top, Self.returnPolicyTopPadding)
                .padding(.bottom, Self.returnPolicyBottomPadding)
                
                Divider()
                    .frame(height: 1)
                    .overlay(Color(uiColor: UIColor.lightGray))
                
                VStack(spacing: 6) {
                    if let returnsAccepted = itemDetailsViewModel.currentItem?.itemReturnsAccpeted {
                        
                        HStack {
                            Text(Self.policyText)
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity)
                            
                            Text(returnsAccepted)
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity)
                        }
                    }
                    
                    if let refundMode = itemDetailsViewModel.currentItem?.itemRefundMode {
                        
                        HStack {
                            Text(Self.refundModeText)
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity)
                            
                            Text(refundMode)
                                .multilineTextAlignment(.leading)
                                .frame(maxWidth: .infinity)
                        }
                    }
                    
                    if let refundWithin = itemDetailsViewModel.currentItem?.itemRetunsWithin {
                        
                        HStack {
                            Text(Self.returnsWithinText)
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity)
                            
                            Text(refundWithin)
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity)
                        }
                    }
                    
                    if let shippingCostPaidBy = itemDetailsViewModel.currentItem?.itemShippingCostPaidBy {
                        
                        HStack {
                            Text(Self.shippingCostPaidByText)
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity)
                            
                            Text(shippingCostPaidBy)
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity)
                        }
                    }
                }
                .padding(.vertical, Self.itemReturnsViewVerticalPadding)
            }
        }
    }
}

extension ItemReturnsView {
    static let returnImage = "return"
    static let returnPolicyText = "Return policy"
    static let policyText = "Policy"
    static let refundModeText = "Refund Mode"
    static let returnsWithinText = "Refund Within"
    static let shippingCostPaidByText = "Shipping Cost Paid By"
    static let returnPolicyTopPadding = 10.0
    static let returnPolicyBottomPadding = 15.0
    static let itemReturnsViewVerticalPadding = 9.0
}
