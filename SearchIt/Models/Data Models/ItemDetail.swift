/**
 `ItemDetail`

 A data structure representing detailed information about an item.

 - Author: Omkar Nikhal
 - Date: 11/23/23
 */
import Foundation

struct ItemDetail {
    
    /// The unique identifier of the item.
    let itemID: String?
    
    /// The title or name of the item.
    let itemTitle: String?
    
    /// The URL of the item.
    let itemURL: String?
    
    /// The URLs of the item's pictures.
    let itemPictureURL: [String]?
    
    /// The price of the item.
    let itemPrice: Double?
    
    /// The specific details of the item.
    let itemSpecifics: [NameValueList]?
    
    /// The name of the store selling the item.
    let itemStoreName: String?
    
    /// The URL of the store selling the item.
    let itemStoreURL: String?
    
    /// The feedback score of the seller.
    let itemFeedbackScore: Int?
    
    /// The positive feedback percentage of the seller.
    let itemFeedbackPercent: Double?
    
    /// Indicates whether global shipping is available.
    let itemGlobalShipping: Bool?
    
    /// The handling time for the item.
    let itemHandlingTime: Int?
    
    /// Indicates whether returns are accepted for the item.
    let itemReturnsAccpeted: String?
    
    /// The refund mode for returns.
    let itemRefundMode: String?
    
    /// The time frame for returns.
    let itemRetunsWithin: String?
    
    /// The party responsible for paying shipping costs for returns.
    let itemShippingCostPaidBy: String?
    
    /// The Google Photos associated with the item.
    let itemGooglePhotos: [GooglePhotoItem]?
    
    /// The similar items related to the current item.
    let itemSimilarItems: [SimilarItem]?
}

/**
 `SimilarItem`

 A data structure representing a similar item related to the current item.

 - Author: Omkar Nikhal
 - Date: 11/23/23
 */
struct SimilarItem: Hashable, Identifiable {
    
    /// The unique identifier for the item.
    var id = UUID()
    
    /// The index of the similar item.
    let itemIndex: Int?
    
    /// The unique identifier of the similar item.
    let itemID: String?
    
    /// The URL of the image for the similar item.
    let itemImageURL: String?
    
    /// The title or name of the similar item.
    let itemTitle: String?
    
    /// The price of the similar item.
    let itemPrice: Double?
    
    /// The shipping cost of the similar item.
    let itemShippingCost: Double?
    
    /// The number of days left for the similar item.
    let itemDaysLeft: Int?
}
