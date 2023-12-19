//
//  SimilarItemCardView.swift
//  CSCI571-Assi4-nikhal
//
//  Created by Omkar Nikhal on 12/5/23.
//

import SwiftUI
import Kingfisher

struct SimilarItemCardView: View {
    
    var similarItem: SimilarItem
    
    init(_ similarItem: SimilarItem) {
        self.similarItem = similarItem
    }
    
    var body: some View {
        ZStack {
            
            RoundedRectangle(cornerRadius: Self.cardCornerRadius)
                .fill(Color.gray)
                .opacity(Self.innerCardOpacity)
                .frame(width: Self.cardWidth, height: Self.cardHeight)
                .overlay(
                    RoundedRectangle(cornerRadius: Self.cardCornerRadius)
                        .stroke(Color.gray, lineWidth: Self.outerCardStrokeWidth)
                        .opacity(Self.outerCardOpacity)
                )

            VStack(alignment: .leading, spacing: 1) {
                
                KFImage.url(URL(string: similarItem.itemImageURL ?? ""))
                    .placeholder{Color.gray}
                    .resizable()
                    .frame(height: Self.imageHeight)
                    .frame(maxWidth: .infinity)
                    .clipShape(RoundedRectangle(cornerRadius: Self.imageCornerRadius, style: .continuous))
                    .padding(.horizontal, Self.imageHorizontalPadding)
                

                Text(similarItem.itemTitle ?? "")
                    .font(.footnote)
                    .bold()
                    .lineLimit(2)
                    .padding(.horizontal)
                    .padding(.top, Self.titleTopPadding)


                HStack {
                    Text(Self.dollarText + String(format: "%.2f", similarItem.itemShippingCost ?? 0.00))
                        .font(.caption)
                        .foregroundStyle(Color.gray)
                    Spacer()
                    Text(String(similarItem.itemDaysLeft ?? 0) + Self.daysLeftText)
                        .font(.caption)
                        .foregroundStyle(Color.gray)
                }
                .padding(.horizontal)
                .padding(.top, Self.costTopPadding)
                
                HStack {
                    Spacer()
                    Text(Self.dollarText + String(format: "%.2f", similarItem.itemPrice ?? 0.00))
                        .foregroundStyle(Color.blue)
                        .fontWeight(.bold)
                }
                .padding(.horizontal)
                .padding(.vertical, Self.itemPriceVerticalPadding)
            }
            .frame(width: Self.itemViewWidth, height: Self.itemViewHeight)
        }
    }
}

extension SimilarItemCardView {
    static let dollarText = "$"
    static let daysLeftText = " days left"
    static let costTopPadding = 2.0
    static let cardCornerRadius = 20.0
    static let innerCardOpacity = 0.1
    static let outerCardOpacity = 0.4
    static let outerCardStrokeWidth = 2.0
    static let cardWidth = 168.0
    static let cardHeight = 300.0
    static let imageHeight = 165.0
    static let imageCornerRadius = 10.0
    static let imageHorizontalPadding = 6.0
    static let titleTopPadding = 22.0
    static let itemPriceVerticalPadding = 12.0
    static let itemViewWidth = 168.0
    static let itemViewHeight = 298.0
}
