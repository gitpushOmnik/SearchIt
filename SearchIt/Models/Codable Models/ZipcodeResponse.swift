/**
 `ZipcodeResponse`

 A data structure representing the response containing postal codes.

 - Author: Omkar Nikhal
 - Date: 12/3/23
 */
import Foundation

struct ZipcodeResponse: Codable {
    let postalCodes: [PostalCode]
}

struct PostalCode: Codable {
    let postalCode: String?
}
