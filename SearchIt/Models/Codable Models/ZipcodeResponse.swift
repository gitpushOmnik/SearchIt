//
//  ZipcodeResponse.swift
//  CSCI571-Assi4-nikhal
//
//  Created by Omkar Nikhal on 12/3/23.
//

import Foundation

struct ZipcodeResponse: Codable {
    let postalCodes: [PostalCode]
}

struct PostalCode: Codable {
    let postalCode: String?
}
