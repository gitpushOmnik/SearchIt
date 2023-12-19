//
//  ItemDetail.swift
//  CSCI571-Assi4-nikhal
//
//  Created by Omkar Nikhal on 11/23/23.
//

import Foundation

struct ItemDetail {
    let itemID: String?
    let itemTitle: String?
    let itemURL: String?
    let itemPictureURL: [String]?
    let itemPrice: Double?
    let itemSpecifics: [NameValueList]?
    let itemStoreName: String?
    let itemStoreURL: String?
    let itemFeedbackScore: Int?
    let itemFeedbackPercent: Double?
    let itemGlobalShipping: Bool?
    let itemHandlingTime: Int?
    let itemReturnsAccpeted: String?
    let itemRefundMode: String?
    let itemRetunsWithin: String?
    let itemShippingCostPaidBy: String?
    let itemGooglePhotos: [GooglePhotoItem]?
    let itemSimilarItems: [SimilarItem]?
}

struct SimilarItem: Hashable, Identifiable {
    var id = UUID()
    let itemIndex: Int?
    let itemID: String?
    let itemImageURL: String?
    let itemTitle: String?
    let itemPrice: Double?
    let itemShippingCost: Double?
    let itemDaysLeft: Int?
}
