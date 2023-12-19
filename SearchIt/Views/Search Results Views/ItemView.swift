/**
 `ItemView`

 A SwiftUI view displaying details of a search result item or a wish list item.

 - Author: Omkar Nikhal
 - Date: 12/5/23
 */
import SwiftUI
import Kingfisher

struct ItemView: View {
    
    /// The search result item to display.
    var searchResultItem: SearchResultItem?
    
    /// The wish list item to display.
    var wishListItem: WishListItem?
    
    /**
     Initializes an `ItemView` with either a search result item or a wish list item.

     - Parameters:
        - searchResultItem: The search result item to display.
        - wishListItem: The wish list item to display.
     */
    init(searchResultItem: SearchResultItem?, wishListItem: WishListItem?) {
        self.searchResultItem = searchResultItem
        self.wishListItem = wishListItem
    }
    
    var body: some View {
        if let searchResultItem = searchResultItem {
            // Displaying search result item details
            KFImage.url(URL(string: searchResultItem.itemImageURL ?? ""))
                .placeholder { Color.gray }
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
            // Displaying wish list item details
            KFImage.url(URL(string: wishListItem.itemImageURL ?? ""))
                .placeholder { Color.gray }
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
    /// The placeholder text for N/A (Not Available).
    static let naText = "N/A"
    
    /// The height of the list row image.
    static let listRowImageHeight = 79.0
    
    /// The width of the list row image.
    static let listRowImageWidth = 82.0
    
    /// The spacing between list items.
    static let listItemsSpacing = 7.0
}
