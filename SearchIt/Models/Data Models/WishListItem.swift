/**
 `WishListItem`

 A data structure representing an item in the wish list.

 - Author: Omkar Nikhal
 - Date: 11/22/23
 */
import Foundation

struct WishListItem {
    
    /// The unique identifier of the item.
    let itemID: String?
    
    /// The index number of the item in the wish list.
    let itemIndexNumber: String?
    
    /// The serial number assigned to the item.
    let itemSerialNumber: String?
    
    /// The URL of the item's image.
    let itemImageURL: String?
    
    /// The title or name of the item.
    let itemTitle: String?
    
    /// The price of the item, formatted as a string.
    let itemPrice: String?
    
    /// The postal code or ZIP code associated with the item.
    let itemZipcode: String?
    
    /// The shipping cost of the item, formatted as a string.
    let itemShippingCost: String?
    
    /// The condition of the item.
    let itemConditionName: String?
}
