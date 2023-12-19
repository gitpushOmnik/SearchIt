/**
 `SimilarItemCardView`

 A SwiftUI view to display a card for a similar item, including its image, title, shipping cost, days left, and price.

 - Author: Omkar Nikhal
 - Date: 12/5/23
 */
import SwiftUI
import Kingfisher

struct SimilarItemCardView: View {
    
    /// The similar item to be displayed in the card.
    var similarItem: SimilarItem
    
    /**
     Initializes a `SimilarItemCardView` with the specified similar item.

     - Parameters:
        - similarItem: The similar item to be displayed in the card.
     */
    init(_ similarItem: SimilarItem) {
        self.similarItem = similarItem
    }
    
    var body: some View {
        ZStack {
            
            // Inner RoundedRectangle for background
            RoundedRectangle(cornerRadius: Self.cardCornerRadius)
                .fill(Color.gray)
                .opacity(Self.innerCardOpacity)
                .frame(width: Self.cardWidth, height: Self.cardHeight)
                
                // Outer RoundedRectangle for border
                .overlay(
                    RoundedRectangle(cornerRadius: Self.cardCornerRadius)
                        .stroke(Color.gray, lineWidth: Self.outerCardStrokeWidth)
                        .opacity(Self.outerCardOpacity)
                )

            VStack(alignment: .leading, spacing: 1) {
                
                // Display item image using Kingfisher
                KFImage.url(URL(string: similarItem.itemImageURL ?? ""))
                    .placeholder{Color.gray}
                    .resizable()
                    .frame(height: Self.imageHeight)
                    .frame(maxWidth: .infinity)
                    .clipShape(RoundedRectangle(cornerRadius: Self.imageCornerRadius, style: .continuous))
                    .padding(.horizontal, Self.imageHorizontalPadding)

                // Display item title
                Text(similarItem.itemTitle ?? "")
                    .font(.footnote)
                    .bold()
                    .lineLimit(2)
                    .padding(.horizontal)
                    .padding(.top, Self.titleTopPadding)

                // Display item shipping cost and days left
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

                // Display item price
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
    /// The currency symbol.
    static let dollarText = "$"
    
    /// The text suffix for "days left".
    static let daysLeftText = " days left"
    
    /// The top padding for shipping cost and days left section.
    static let costTopPadding = 2.0
    
    /// The corner radius for the card.
    static let cardCornerRadius = 20.0
    
    /// The opacity of the inner card background.
    static let innerCardOpacity = 0.1
    
    /// The opacity of the outer card border.
    static let outerCardOpacity = 0.4
    
    /// The stroke width of the outer card border.
    static let outerCardStrokeWidth = 2.0
    
    /// The width of the card.
    static let cardWidth = 168.0
    
    /// The height of the card.
    static let cardHeight = 300.0
    
    /// The height of the item image.
    static let imageHeight = 165.0
    
    /// The corner radius of the item image.
    static let imageCornerRadius = 10.0
    
    /// The horizontal padding for the item image.
    static let imageHorizontalPadding = 6.0
    
    /// The top padding for the item title.
    static let titleTopPadding = 22.0
    
    /// The vertical padding for the item price.
    static let itemPriceVerticalPadding = 12.0
    
    /// The width of the entire item view.
    static let itemViewWidth = 168.0
    
    /// The height of the entire item view.
    static let itemViewHeight = 298.0
}
