/**
 `ItemDetailsResponse`

 A data structure representing the response containing item details, similar items, and Google Photos.

 - Author: Omkar Nikhal
 - Date: 11/23/23
 */
import Foundation

struct ItemDetailsResponse: Codable {
    let itemDetails: SearchItemDetails?
    let similarItems: SimilarItems?
    let googlePhotos: GooglePhotos?
}

struct SearchItemDetails: Codable {
    let item: SearchItem?
    
    private enum CodingKeys: String, CodingKey {
        case item = "Item"
    }
}

struct SearchItem: Codable {
    let itemID: String?
    let itemTitle: String?
    let viewItemURLForNaturalSearch: String?
    let pictureURL: [String]?
    let currentPrice: ItemCurrentPrice
    let itemSpecifics: ItemSpecifics?
    let seller: Seller?
    let storefront: Storefront?
    let returnPolicy: ReturnPolicy?
    let globalShipping: Bool
    let handlingTime: Int
    
    private enum CodingKeys: String, CodingKey {
        case itemID = "ItemID"
        case itemTitle = "Title"
        case viewItemURLForNaturalSearch = "ViewItemURLForNaturalSearch"
        case pictureURL = "PictureURL"
        case currentPrice = "CurrentPrice"
        case itemSpecifics = "ItemSpecifics"
        case seller = "Seller"
        case storefront = "Storefront"
        case returnPolicy = "ReturnPolicy"
        case globalShipping = "GlobalShipping"
        case handlingTime = "HandlingTime"
    }
}

struct ItemCurrentPrice: Codable {
    let value: Double?
    
    private enum CodingKeys: String, CodingKey {
        case value = "Value"
    }
}

struct ItemSpecifics: Codable {
    let nameValueList: [NameValueList]?
    
    private enum CodingKeys: String, CodingKey {
        case nameValueList = "NameValueList"
    }
}

struct NameValueList: Identifiable, Hashable, Codable {
    let id = UUID()
    let name: String?
    let value: [String]?
    var valueString: String? {
        return value?.joined(separator: ", ")
    }
    
    private enum CodingKeys: String, CodingKey {
        case name = "Name"
        case value = "Value"
    }
}

struct Seller: Codable {
    let feedbackScore: Int?
    let positiveFeedbackPercent: Double?
    
    private enum CodingKeys: String, CodingKey {
        case feedbackScore = "FeedbackScore"
        case positiveFeedbackPercent = "PositiveFeedbackPercent"
    }
}

struct Storefront: Codable {
    let storeURL: String?
    let storeName: String?
    
    private enum CodingKeys: String, CodingKey {
        case storeURL = "StoreURL"
        case storeName = "StoreName"
    }
}

struct ReturnPolicy: Codable {
    let refund: String?
    let returnsWithin: String?
    let returnsAccepted: String?
    let shippingCostPaidBy: String?
    
    private enum CodingKeys: String, CodingKey {
        case refund = "Refund"
        case returnsWithin = "ReturnsWithin"
        case returnsAccepted = "ReturnsAccepted"
        case shippingCostPaidBy = "ShippingCostPaidBy"
    }
}

struct GooglePhotos: Codable {
    let items: [GooglePhotoItem]?
}

struct GooglePhotoItem: Hashable, Codable {
    let link: String?
}

struct SimilarItems: Codable {
    let getSimilarItemsResponse: GetSimilarItemsResponse?
}

struct GetSimilarItemsResponse: Codable {
    let itemRecommendations: ItemRecommendations?
}

struct ItemRecommendations: Codable {
    let item: [SimilarItemResponse]?
}

struct SimilarItemResponse: Codable {
    let itemId: String?
    let imageURL: String?
    let title: String?
    let buyItNowPrice: BuyItNowPrice?
    let shippingCost: ShippingCost?
    let timeLeft: String?
    var daysLeft: Int {
        
        var duration = timeLeft ?? ""
        if duration.hasPrefix("P") {
            duration.removeFirst(1)
        }
        
        var days: Int = 0
        
        if let index = duration.firstIndex(of: "D") {
            days = Int(duration[..<index]) ?? 0
        }

        return days
    }
}

struct BuyItNowPrice: Codable {
    let value: String?
    
    private enum CodingKeys: String, CodingKey {
        case value = "__value__"
    }
}

struct ShippingCost: Codable {
    let value: String?
    
    private enum CodingKeys: String, CodingKey {
        case value = "__value__"
    }
}

