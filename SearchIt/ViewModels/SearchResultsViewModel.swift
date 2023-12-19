/**
 `SearchResultsViewModel`

 The ViewModel responsible for managing search results.

 - Author: Omkar Nikhal
 - Date: 11/21/23
 */
import Foundation
import Alamofire

class SearchResultsViewModel: ObservableObject {
    
    /// Published property representing the list of search result items.
    @Published var searchResultItems: [SearchResultItem] = []
    
    /// Published property indicating whether search results are currently being loaded.
    @Published var isSearchResultsLoading: Bool = false
    
    /// Dictionary to map item IDs to their shipping costs.
    @Published var shippingCostMapping: Dictionary<String?, String?> = Dictionary<String?, String?>()
    
    /**
     Fetches search result items based on the provided search query.

     - Parameter searchResultsQuery: The search query to fetch results.
     */
    func getSearchResultItems(_ searchResultsQuery: String) {
        isSearchResultsLoading = true
        let finalSearchResultsQuery = Self.getResultsURLString + searchResultsQuery
        let searchResultsQueryURL = URL(string: finalSearchResultsQuery)
        guard let searchResultsQueryURL else {return}

        Task {
            AF.request(searchResultsQueryURL)
                .validate()
                .responseDecodable(of: FindItemsAdvancedResponse.self) { jsonResponse in
                    switch jsonResponse.result {
                        
                    case .success(let decodedJSONResponse):
                        self.processDecodedResponse(decodedJSONResponse)
                        
                    case .failure(let error):
                        print("Request failed with error: \(error)")
                    }
                }
        }
    }
    
    /**
     Processes the decoded JSON response and updates the ViewModel with search results.

     - Parameter decodedJSONResponse: The decoded JSON response.
     */
    func processDecodedResponse(_ decodedJSONResponse: FindItemsAdvancedResponse){
        
        guard let searchResultsResponse = decodedJSONResponse.findItemsAdvancedResponse,
              let responseAcknowledgement = searchResultsResponse.first?.ack,
              responseAcknowledgement.first == Self.success,
              let searchResults = searchResultsResponse.first?.searchResult,
              searchResults.count > 0,
              let searchResultItems = searchResults.first?.item,
              searchResultItems.count > 0 else {
            self.searchResultItems = []
            self.shippingCostMapping = Dictionary<String?, String?>()
            self.isSearchResultsLoading = false
            return
        }
        
        var searchResultItemsList: [SearchResultItem] = []
        var shippingCostMappingDictionary: Dictionary<String?, String?> = Dictionary<String?, String?>()
        
        for itemIndex in searchResultItems.indices {
            let searchResultItem = searchResultItems[itemIndex]
            
            let itemID = searchResultItem.itemId?.first
            let itemIndexNumber = String(itemIndex)
            let itemSerialNumber = String(itemIndex + 1)
            let itemImageURL = searchResultItem.galleryURL?.first
            let itemTitle = searchResultItem.title?.first ?? Self.naString
            
            var itemPrice = Self.naString
            if let currentPrice = searchResultItem.sellingStatus?.first?.currentPrice?.first?.value {
                itemPrice = Self.dollarText + currentPrice
            }
            
            var itemZipcode = Self.naString
            if let itemPostalCode = searchResultItem.postalCode?.first {
                itemZipcode = itemPostalCode
            }
            
            var itemShippingCost:String? = nil
            var itemReturnsAccepted = Self.naString
            var itemExpeditedShipping = Self.naString
            var itemOneDayShipping = Self.naString
            var itemHandlingTime = Self.naString
            var itemShippingLocations = Self.naString
            
            if let shippingInfo = searchResultItem.shippingInfo?.first {
                var itemShippingCostString = Self.naString
                
                if let shippingServiceCost = shippingInfo.shippingServiceCost?.first?.value {
                    if let cost = Double(shippingServiceCost), cost == 0 {
                        itemShippingCostString = Self.freeShippingText
                    } else {
                        itemShippingCostString = Self.dollarText + shippingServiceCost
                    }
                }
                
                itemShippingCost = itemShippingCostString
                shippingCostMappingDictionary.updateValue(itemShippingCost, forKey: itemID)

                itemReturnsAccepted = searchResultItem.returnsAccepted?.first ?? Self.naString
                itemExpeditedShipping = shippingInfo.expeditedShipping?.first ?? Self.naString
                itemOneDayShipping = shippingInfo.oneDayShippingAvailable?.first ?? Self.naString
                itemHandlingTime = shippingInfo.handlingTime?.first ?? Self.naString
                itemShippingLocations = shippingInfo.shipToLocations?.first ?? Self.naString
            }
            
            var itemSellerName = Self.naString
            if let sellerInfo = searchResultItem.sellerInfo?.first,
               let sellerUserName = sellerInfo.sellerUserName?.first {
                itemSellerName = sellerUserName
            }
            
            var itemConditionName = Self.naString
            
            if let firstConditionId = searchResultItem.condition?.first?.conditionId?.first {
                
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
            
            let searchResultItemObject = SearchResultItem(itemID: itemID,
                                                          itemIndexNumber: itemIndexNumber,
                                                          itemSerialNumber: itemSerialNumber,
                                                          itemImageURL: itemImageURL,
                                                          itemTitle: itemTitle,
                                                          itemPrice: itemPrice,
                                                          itemZipcode: itemZipcode,
                                                          itemShippingCost: itemShippingCost,
                                                          itemReturnsAccepted: itemReturnsAccepted,
                                                          itemExpeditedShipping: itemExpeditedShipping,
                                                          itemOneDayShipping: itemOneDayShipping,
                                                          itemHandlingTime: itemHandlingTime,
                                                          itemShippingLocations: itemShippingLocations,
                                                          itemSellerName: itemSellerName,
                                                          itemConditionName: itemConditionName)
            
            
            searchResultItemsList.append(searchResultItemObject)
        }
        
        self.searchResultItems = searchResultItemsList
        self.shippingCostMapping = shippingCostMappingDictionary
        self.isSearchResultsLoading = false
    }
    
    /**
     Clears the list of search result items and the shipping cost mapping.
     */
    func clearSearchResults() {
        searchResultItems = []
        shippingCostMapping = Dictionary<String?, String?>()
    }
}

extension SearchResultsViewModel  {
    
    // Static properties and constants
    
    /// URL string for fetching search results.
    static let getResultsURLString = "https://csci571-assi3-nikhal-backend.uc.r.appspot.com/getSearchItems?"
    
    /// Success message for API response.
    static let success = "Success"
    
    /// Placeholder string for N/A values.
    static let naString = "NA"
    
    /// Currency symbol for displaying prices.
    static let dollarText = "$"
    
    /// Text for free shipping.
    static let freeShippingText = "FREE SHIPPING"
    
    /// Enumeration representing item conditions.
    enum ItemCondition: String {
        case new = "NEW"
        case refurbished = "REFURBISHED"
        case used = "USED"
        case unknown = "NA"
    }
}
