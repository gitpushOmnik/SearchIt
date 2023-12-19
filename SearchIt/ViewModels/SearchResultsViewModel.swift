//
//  ServerViewModel.swift
//  CSCI571-Assi4-nikhal
//
//  Created by Omkar Nikhal on 11/21/23.
//

import Foundation
import Alamofire

class SearchResultsViewModel: ObservableObject {
    
    @Published var searchResultItems: [SearchResultItem] = []
    @Published var isSearchResultsLoading: Bool = false
    @Published var shippingCostMapping: Dictionary<String?, String?> = Dictionary<String?, String?>()
    
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
    
    func clearSearchResults() {
        searchResultItems = []
        shippingCostMapping = Dictionary<String?, String?>()
    }
}

extension SearchResultsViewModel  {
    static let getResultsURLString = "https://csci571-assi3-nikhal-backend.uc.r.appspot.com/getSearchItems?"
    static let success = "Success"
    static let naString = "NA"
    static let dollarText = "$"
    static let freeShippingText = "FREE SHIPPING"
    
    enum ItemCondition: String {
        case new = "NEW"
        case refurbished = "REFURBISHED"
        case used = "USED"
        case unknown = "NA"
    }
}
