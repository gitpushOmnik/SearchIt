/**
 `SearchResultItem`

 A data structure representing an item in the search results.

 - Author: Omkar Nikhal
 - Date: 11/22/23
 */
import Foundation

struct SearchResultItem {
    
    /// The unique identifier of the item.
    let itemID: String?
    
    /// The index number of the item in the search results.
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
    
    /// Indicates whether returns are accepted for the item.
    let itemReturnsAccepted: String?
    
    /// Indicates whether expedited shipping is available for the item.
    let itemExpeditedShipping: String?
    
    /// Indicates whether one-day shipping is available for the item.
    let itemOneDayShipping: String?
    
    /// The handling time for shipping the item.
    let itemHandlingTime: String?
    
    /// The locations to which the item can be shipped.
    let itemShippingLocations: String?
    
    /// The name of the seller of the item.
    let itemSellerName: String?
    
    /// The condition of the item.
    let itemConditionName: String?
}
