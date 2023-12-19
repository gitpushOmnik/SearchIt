/**
 `FindItemsAdvancedResponse`

 A data structure representing the response for finding advanced search items.

 - Author: Omkar Nikhal
 - Date: 11/22/23
 */
import Foundation

struct FindItemsAdvancedResponse: Codable {
    let findItemsAdvancedResponse: [SearchResults]?
}
struct SearchResults: Codable {
    let ack: [String]?
    let searchResult: [SearchResult]?
}

struct SearchResult: Codable {
    let item: [Item]?
}

struct Item: Codable {
    let itemId: [String]?
    let title: [String]?
    let galleryURL: [String]?
    let postalCode: [String]?
    let returnsAccepted: [String]?
    let sellingStatus: [SellingStatus]?
    let shippingInfo: [ShippingInfo]?
    let sellerInfo: [SellerInfo]?
    let condition: [Condition]?
}

struct SellerInfo: Codable {
    let sellerUserName: [String]?
}

struct ShippingInfo: Codable {
    let shippingServiceCost: [ShippingServiceCost]?
    let shippingType: [String]?
    let shipToLocations: [String]?
    let expeditedShipping: [String]?
    let oneDayShippingAvailable: [String]?
    let handlingTime: [String]?
}

struct ShippingServiceCost: Codable {
    let value: String?
    
    private enum CodingKeys: String, CodingKey {
        case value = "__value__"
    }
}

struct SellingStatus: Codable {
    let currentPrice: [CurrentPrice]?
}

struct CurrentPrice: Codable {
    let value: String?
    
    private enum CodingKeys: String, CodingKey {
        case value = "__value__"
    }
}

struct Condition: Codable {
    let conditionId: [String]?
    let conditionDisplayName: [String]?
}


