//
//  SearchFormViewModel.swift
//  CSCI571-Assi4-nikhal
//
//  Created by Omkar Nikhal on 11/20/23.
//

import Foundation
import SwiftUI
import Alamofire

class SearchFormViewModel: ObservableObject {
    @Published var searchForm: SearchForm
    @Published var toast: Toast
    
    init(searchForm: SearchForm, toast: Toast) {
        self.searchForm = searchForm
        self.toast = toast
    }
    
    func validateSearchForm() -> Bool{
        
        let keywordsHasWhitespace = searchForm.keywords.trimmingCharacters(in: .whitespaces).isEmpty
        
        if keywordsHasWhitespace {
            toast.toastString = Self.madatoryKeywordsText
            toast.showToast = true
            searchForm.isFormValid = false
            return false
        }
        
        if searchForm.enterCustomLocation {
            
            let zipcodeHasWhitespace = searchForm.userInputZipcode.trimmingCharacters(in: .whitespaces).isEmpty
            
            if zipcodeHasWhitespace {
                toast.toastString = Self.mandatoryZipcodeText
                toast.showToast = true
                searchForm.isFormValid = false
                return false
            }
            
            let zipcodeRange = NSRange(location: 0, length: searchForm.userInputZipcode.utf16.count)
            let zipcodeRegex = try! NSRegularExpression(pattern: Self.zipcodeRegex)
            
            if zipcodeRegex.firstMatch(in: searchForm.userInputZipcode, options: [], range: zipcodeRange) == nil {
                toast.toastString = Self.invalidZipcodeText
                toast.showToast = true
                searchForm.isFormValid = false
                return false
            }
        }
        
        searchForm.isFormValid = true
        return true
    }
    
        
    func generateSearchResultsQuery() -> String {
        
        let keywordsString = Self.keywordsParameter + searchForm.keywords
        
        var selectedCategory = ""
        
        if let categoryType = CategoryType(rawValue: searchForm.categoryType) {
            switch categoryType {
            case .art:
                selectedCategory = CategoryParameter.art.rawValue
            case .baby:
                selectedCategory = CategoryParameter.baby.rawValue
            case .books:
                selectedCategory = CategoryParameter.books.rawValue
            case .clothing:
                selectedCategory = CategoryParameter.clothing.rawValue
            case .computers:
                selectedCategory = CategoryParameter.computers.rawValue
            case .health:
                selectedCategory = CategoryParameter.health.rawValue
            case .music:
                selectedCategory = CategoryParameter.music.rawValue
            case .videoGames:
                selectedCategory = CategoryParameter.videoGames.rawValue
            }
        }
        
        let categoryTypeString = Self.categoryTypeParameter + selectedCategory
        
        var conditionString = ""
        
        if(searchForm.newCondition) {
            conditionString += Self.newConditionParameter
        }
        
        if(searchForm.usedCondition) {
            conditionString += Self.usedConditionParameter
        }
        
        
        var shippingString = "";
        
        if(searchForm.localShipping) {
            shippingString += Self.localShippingParameter
        }
        
        if(searchForm.freeShipping) {
            shippingString += Self.freeShippingParameter
        }
        
        var distanceString = Self.distanceParameter
        
        if searchForm.distance == "" {
            distanceString += Self.defaultDistance
        } else {
            distanceString += searchForm.distance
        }
        
        
        var locationString = Self.zipcodeParameter;
        
        if searchForm.enterCustomLocation {
            locationString += searchForm.userInputZipcode;
        } else {
            locationString += searchForm.currentLocationZipcode
        }
        
        let searchQueryString = keywordsString + categoryTypeString + conditionString + shippingString + distanceString + locationString
        
        return searchQueryString
    }
    
    func fetchCurrentLocation() {
        Task {
            AF.request(Self.currentLocationAPI)
                .validate()
                .responseDecodable(of: CurrentLocationResponse.self) { jsonResponse in
                    switch jsonResponse.result {
                    case .success(let decodedJSONResponse):
                        self.searchForm.currentLocationZipcode = decodedJSONResponse.zip
                    case .failure(let error):
                        print("Request failed with error: \(error)")
                    }
                }
        }
    }
    
    func fetchZipcodes() {
        Task {
            AF.request(Self.autoCompleteAPI + searchForm.userInputZipcode)
                .validate()
                .responseDecodable(of: ZipcodeResponse.self) { jsonResponse in
                    switch jsonResponse.result {
                    case .success(let decodedJSONResponse):
                        self.storeFetchedZipcodes(decodedJSONResponse)
                        self.searchForm.zipcodeFetched = true
                    case .failure(let error):
                        print("Request failed with error: \(error)")
                    }
                }
        }
    }
    
    func storeFetchedZipcodes(_ zipcodeResponse: ZipcodeResponse) {
        searchForm.fetchedZipcodes = []

        for zipcode in zipcodeResponse.postalCodes {
            if let postalCode = zipcode.postalCode {
                searchForm.fetchedZipcodes.append(postalCode)
            }
        }
    }
    
    func clearForm() {
        searchForm.keywords = ""
        searchForm.categoryType = "All"
        searchForm.newCondition = false
        searchForm.usedCondition = false
        searchForm.unspecifiedCondition = false
        searchForm.localShipping = false
        searchForm.freeShipping = false
        searchForm.distance = ""
        searchForm.enterCustomLocation = false
        searchForm.isFormValid = false
        searchForm.currentLocationZipcode = "90007"
        searchForm.userInputZipcode = ""
        searchForm.fetchedZipcodes = []
        searchForm.zipcodeFetched = false
    }
}

extension SearchFormViewModel {
    
    static let madatoryKeywordsText = "Keyword is mandatory"
    static let mandatoryZipcodeText = "Zipcode is mandatory"
    static let zipcodeRegex = "[0-9]{5,5}"
    static let invalidZipcodeText = "Zipcode is invalid"
    static let defaultDistance = "10"
    static let currentLocationAPI = "http://ip-api.com/json"
    static let autoCompleteAPI = "https://csci571-assi3-nikhal-backend.uc.r.appspot.com/autocompleteZipcode?zipcode="
    
    enum CategoryType: String {
        case art = "Art"
        case baby = "Baby"
        case books = "Books"
        case clothing = "Clothing,Shoes & Accesories"
        case computers = "Computers/Tablets & Networking"
        case health = "Health & Beauty"
        case music = "Music"
        case videoGames = "Video games & Consoles"
    }
    
    enum CategoryParameter: String {
        case art = "art"
        case baby = "baby"
        case books = "books"
        case clothing = "clothing"
        case computers = "computers"
        case health = "health"
        case music = "music"
        case videoGames = "videoGames"
    }
    
    static let keywordsParameter = "keywords="
    static let categoryTypeParameter = "&categoryType="
    static let newConditionParameter = "&condition=new"
    static let usedConditionParameter = "&condition=used"
    static let localShippingParameter = "&shipping=local"
    static let freeShippingParameter = "&shipping=free"
    static let distanceParameter = "&distance="
    static let zipcodeParameter = "&zipcode="
}
