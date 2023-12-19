/**
 `WishListViewModel`

 The ViewModel responsible for managing the wishlist functionality.

 - Author: Omkar Nikhal
 - Date: 11/22/23
 */
import Foundation
import Alamofire

class WishListViewModel: ObservableObject {
    
    /// Published property representing the list of wishlist items.
    @Published var wishListItems: [WishListItem] = []
    
    /// Published property representing the list of wishlist item IDs.
    @Published var wishListItemIDs: [String] = []
    
    /// Published property indicating whether the wishlist is currently loading.
    @Published var isWishListLoading: Bool = false
    
    /// Published property representing the total shopping cost of items in the wishlist.
    @Published var totalShoppingCost: Double = 0.0
    
    /// Published property indicating whether an item has been added to the wishlist.
    @Published var addedToWishList: Bool = false
    
    /// Published property indicating whether an item has been removed from the wishlist.
    @Published var removedFromWishList: Bool = false
    
    /**
     Fetches wishlist items based on the provided query.

     - Parameter finalWishListQuery: The final query for fetching wishlist items.
     */
    func getWishListItems(_ finalWishListQuery: String) {
        if wishListItems.count == 0 {
            isWishListLoading = true
        }
        let wishListQueryURL = URL(string: finalWishListQuery)
        guard let wishListQueryURL else {return}
        Task {
            AF.request(wishListQueryURL)
                .validate()
                .responseDecodable(of: [WishListItemsResponse].self) { jsonResponse in
                    switch jsonResponse.result {
                    case .success(let decodedJSONResponse):
                        self.processDecodedWishListResponse(decodedJSONResponse)
                        
                    case .failure(let error):
                        print("Request failed with error: \(error)")
                    }
                }
        }
    }
    
    /**
     Adds an item to the wishlist.

     - Parameters:
        - itemID: The ID of the item to be added.
        - calledFromRoot: Indicates whether the method is called from the root.
     */
    func addWishListItems(_ itemID: String, _ calledFromRoot: Bool) {
        if calledFromRoot {
            addedToWishList = true
        }
        let addToWishListURLString = Self.addToWishListQuery + Self.idString + String(itemID)
        wishListItemIDs.append(itemID)
        getWishListItems(addToWishListURLString)
    }
    
    /**
     Removes an item from the wishlist.

     - Parameters:
        - itemID: The ID of the item to be removed.
        - calledFromRoot: Indicates whether the method is called from the root.
     */
    func removeFromWishListItems(_ itemID: String, _ calledFromRoot: Bool) {
        if calledFromRoot {
            removedFromWishList = true
        }
        let removeFromWishListURLString = Self.removeFromWishListQuery + "id=" + String(itemID)
        
        if let itemIndex = self.wishListItemIDs.firstIndex(of: itemID) {
            self.wishListItemIDs.remove(at: itemIndex)
        }
        
        guard let indexToRemove = wishListItems.firstIndex(where: { $0.itemID == itemID }) else {return}
        
        let itemPriceString = wishListItems[indexToRemove].itemPrice ?? ""
        
        if let itemPrice = Double(itemPriceString.replacingOccurrences(of: Self.dollarText, with: "")) {
            totalShoppingCost = totalShoppingCost - itemPrice
        }
        
        wishListItems.remove(at: indexToRemove)
        getWishListItems(removeFromWishListURLString)
    }
    
    /**
     Processes the decoded JSON response from the wishlist API.

     - Parameter decodedJSONResponse: The decoded JSON response containing wishlist items.
     */
    func processDecodedWishListResponse(_ decodedJSONResponse: [WishListItemsResponse]) {
        guard decodedJSONResponse.count > 0 else {
            self.isWishListLoading = false
            return
        }
        var wishListItemsResponseList: [WishListItem] = []
        var wishListResponseShoppingCost: Double = 0.00
        for itemIndex in decodedJSONResponse.indices {
            
            if let itemDetails = decodedJSONResponse[itemIndex].itemDetails {
                let wishListItem = itemDetails
                
                let itemID = wishListItem.itemId?.first
                
                if wishListItemIDs.contains(itemID ?? "") == false {
                    wishListItemIDs.append(itemID ?? "")
                }
                let itemIndexNumber = String(itemIndex)
                let itemSerialNumber = String(itemIndex + 1)
                let itemImageURL = wishListItem.galleryURL?.first
                let itemTitle = wishListItem.title?.first ?? Self.naString
                
                var itemPrice = Self.naString
                if let currentPrice = wishListItem.sellingStatus?.first?.currentPrice?.first?.value {
                    wishListResponseShoppingCost += Double(currentPrice) ?? 0.0
                    itemPrice = Self.dollarText + currentPrice
                }
                
                var itemZipcode = Self.naString
                if let itemPostalCode = wishListItem.postalCode?.first {
                    itemZipcode = itemPostalCode
                }
                
                var itemShippingCost:String? = nil
                
                if let shippingInfo = wishListItem.shippingInfo?.first {
                    var itemShippingCostString = Self.naString
                    
                    if let shippingServiceCost = shippingInfo.shippingServiceCost?.first?.value {
                        if let cost = Double(shippingServiceCost), cost == 0 {
                            itemShippingCostString = Self.freeShipping
                        } else {
                            itemShippingCostString = Self.dollarText + shippingServiceCost
                        }
                    }
                    
                    itemShippingCost = itemShippingCostString
                }
                
                
                var itemConditionName = Self.naString
                
                if let firstConditionId = wishListItem.condition?.first?.conditionId?.first {
                    switch firstConditionId {
                    case "1000":
                        itemConditionName = ItemCondition.new.rawValue
                    case "2000", "2500":
                        itemConditionName = ItemCondition.refurbished.rawValue
                    case "3000", "4000", "5000", "6000":
                        itemConditionName = ItemCondition.used.rawValue
                    default:
                        break
                    }
                }
                
                let wishListItemObject = WishListItem(itemID: itemID,
                                                      itemIndexNumber: itemIndexNumber,
                                                      itemSerialNumber: itemSerialNumber,
                                                      itemImageURL: itemImageURL,
                                                      itemTitle: itemTitle,
                                                      itemPrice: itemPrice,
                                                      itemZipcode: itemZipcode,
                                                      itemShippingCost: itemShippingCost,
                                                      itemConditionName: itemConditionName)
                
                wishListItemsResponseList.append(wishListItemObject)
            }
        }
        self.wishListItems = wishListItemsResponseList
        self.totalShoppingCost = wishListResponseShoppingCost
        self.isWishListLoading = false
    }
}

extension WishListViewModel  {
    // Static properties and constants
    
    /// The URL string for retrieving the wishlist.
    static let getWishListURLString = "https://csci571-assi3-nikhal-backend.uc.r.appspot.com/retrieveWishList"
    
    /// Success message.
    static let success = "Success"
    
    /// Placeholder string for "Not Available."
    static let naString = "NA"
    
    /// URL query for adding items to the wishlist.
    static let addToWishListQuery = "https://csci571-assi3-nikhal-backend.uc.r.appspot.com/modifyWishList/?operation=addToWishList&"
    
    /// URL query for removing items from the wishlist.
    static let removeFromWishListQuery = "https://csci571-assi3-nikhal-backend.uc.r.appspot.com/modifyWishList/?operation=deleteFromWishList&"
    
    /// String representing free shipping.
    static let freeShipping = "FREE SHIPPING"
    
    /// Identifier string for item ID in the query.
    static let idString = "id="
    
    /// Currency symbol.
    static let dollarText = "$"
    
    /// Enumeration representing item conditions.
    enum ItemCondition: String {
        case new = "NEW"
        case refurbished = "REFURBISHED"
        case used = "USED"
        case unknown = "NA"
    }
}
