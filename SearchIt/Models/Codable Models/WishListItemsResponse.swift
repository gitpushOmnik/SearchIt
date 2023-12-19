//
//  WishListItemsResponse.swift
//  CSCI571-Assi4-nikhal
//
//  Created by Omkar Nikhal on 11/23/23.
//

import SwiftUI

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
