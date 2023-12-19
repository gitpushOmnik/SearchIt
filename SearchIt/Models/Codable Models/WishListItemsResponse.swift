/**
 `WishListItemsResponse`

 A data structure representing the response containing wish list items.

 - Author: Omkar Nikhal
 - Date: 11/23/23
 */
import Foundation

struct WishListItemsResponse: Codable {
    let itemDetails: ItemDetails?
}

struct ItemDetails: Codable {
    let itemId: [String]?
    let title: [String]?
    let galleryURL: [String]?
    let postalCode: [String]?
    let shippingInfo: [ShippingInfo]?
    let sellingStatus: [SellingStatus]?
    let condition: [Condition]?
}
