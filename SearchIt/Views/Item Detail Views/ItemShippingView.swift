//
//  ItemShippingView.swift
//  CSCI571-Assi4-nikhal
//
//  Created by Omkar Nikhal on 11/23/23.
//

import SwiftUI

struct ItemShippingView: View {
    
    @ObservedObject var itemDetailsViewModel: ItemDetailsViewModel
    var itemShippingCost: String?
    @State var showProgressView = true

    var body: some View {
        VStack {
            if showProgressView{
                ProgressView()
            } else {
                VStack(alignment: .leading, spacing: 0) {
                    ItemSellerView(itemDetailsViewModel)
                    
                    ItemShippingCostView(itemDetailsViewModel, itemShippingCost)
                    
                    ItemReturnsView(itemDetailsViewModel)
                    
                    Spacer()
                }
                .padding(.top, Self.itemShippingViewTopPadding)
            }
        }.onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                showProgressView = false
            }
        }
    }
}

extension ItemShippingView {
    static let itemShippingViewTopPadding = 60.0
}

