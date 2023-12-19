//
//  ItemDetailsViewModel.swift
//  CSCI571-Assi4-nikhal
//
//  Created by Omkar Nikhal on 11/23/23.
//

import Foundation
import Alamofire

class ItemDetailsViewModel: ObservableObject {
    
    @Published var currentItem: ItemDetail?
    @Published var isItemDetailsLoading: Bool = false
    
    func getItemDetails(_ itemID: String) {
        isItemDetailsLoading = true
        let itemIDString = Self.idText + String(itemID);
        let finalItemDetailsQueryString = Self.itemDetailsQueryString + itemIDString
        
        let itemDetailsQueryURL = URL(string: finalItemDetailsQueryString)
        guard let itemDetailsQueryURL else {return}
        
        Task {
            AF.request(itemDetailsQueryURL)
                .validate()
                .responseDecodable(of: ItemDetailsResponse.self) { jsonResponse in
                    switch jsonResponse.result {
                    case .success(let decodedJSONResponse):
                        self.processDecodedResponse(decodedJSONResponse)
                        self.isItemDetailsLoading = false
                        
                    case .failure(let error):
                        print("Request failed with error: \(error)")
                    }
                }
        }
    }
    
    func processDecodedResponse(_ decodedJSONResponse: ItemDetailsResponse){
        
        guard let itemDetails = decodedJSONResponse.itemDetails?.item else {return}
        
        let itemID = itemDetails.itemID
        let itemTitle = itemDetails.itemTitle
        let itemURL = itemDetails.viewItemURLForNaturalSearch
        let itemPictureURL = itemDetails.pictureURL
        let itemPrice = itemDetails.currentPrice.value
        let itemSpecifics = itemDetails.itemSpecifics?.nameValueList
        let itemStoreName = itemDetails.storefront?.storeName
        let itemStoreURL = itemDetails.storefront?.storeURL
        let itemFeedbackScore = itemDetails.seller?.feedbackScore
        let itemFeedbackPercent = itemDetails.seller?.positiveFeedbackPercent
        let itemGlobalShipping = itemDetails.globalShipping
        let itemHandlingTime = itemDetails.handlingTime
        let itemReturnsAccpeted = itemDetails.returnPolicy?.returnsAccepted
        let itemRefundMode = itemDetails.returnPolicy?.refund
        let itemRetunsWithin = itemDetails.returnPolicy?.returnsWithin
        let itemShippingCostPaidBy = itemDetails.returnPolicy?.shippingCostPaidBy
        
        guard let googlePhotos = decodedJSONResponse.googlePhotos else {return}
        let itemGooglePhotos = googlePhotos.items
        
        guard let similarItemsResponse = decodedJSONResponse.similarItems?.getSimilarItemsResponse?.itemRecommendations else {return}
        let items = similarItemsResponse.item
        var itemSimilarItems: [SimilarItem] = []
        
        if let similarItems = items {
            for (index, similarItem) in similarItems.enumerated() {
                let similarItem = SimilarItem(itemIndex: index,
                                              itemID: similarItem.itemId,
                                              itemImageURL: similarItem.imageURL,
                                              itemTitle: similarItem.title,
                                              itemPrice: Double(similarItem.buyItNowPrice?.value ?? Self.defaultDoublePrice),
                                              itemShippingCost: Double(similarItem.shippingCost?.value ?? Self.defaultDoublePrice),
                                              itemDaysLeft: similarItem.daysLeft)
 
                itemSimilarItems.append(similarItem)
            }
        }
        
        self.currentItem = ItemDetail(itemID: itemID,
                                      itemTitle: itemTitle,
                                      itemURL: itemURL,
                                      itemPictureURL: itemPictureURL,
                                      itemPrice: itemPrice,
                                      itemSpecifics: itemSpecifics,
                                      itemStoreName: itemStoreName, 
                                      itemStoreURL: itemStoreURL,
                                      itemFeedbackScore: itemFeedbackScore,
                                      itemFeedbackPercent: itemFeedbackPercent,
                                      itemGlobalShipping: itemGlobalShipping,
                                      itemHandlingTime: itemHandlingTime,
                                      itemReturnsAccpeted: itemReturnsAccpeted,
                                      itemRefundMode: itemRefundMode,
                                      itemRetunsWithin: itemRetunsWithin,
                                      itemShippingCostPaidBy: itemShippingCostPaidBy,
                                      itemGooglePhotos: itemGooglePhotos,
                                      itemSimilarItems: itemSimilarItems)
        
    }
}

extension ItemDetailsViewModel {
    static let idText = "id="
    static let defaultDoublePrice = "0.00"
    static let itemDetailsQueryString = "https://csci571-assi3-nikhal-backend.uc.r.appspot.com/getItemDetails/?"
}
