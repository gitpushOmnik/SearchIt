/**
 `SearchFormViewModel`

 The ViewModel responsible for managing the search form functionality.

 - Author: Omkar Nikhal
 - Date: 11/20/23
 */
import Foundation
import SwiftUI
import Alamofire

class SearchFormViewModel: ObservableObject {
    
    /// Published property representing the search form.
    @Published var searchForm: SearchForm
    
    /// Published property representing the toast for displaying messages.
    @Published var toast: Toast
    
    /**
     Initializes the SearchFormViewModel with a search form and a toast.

     - Parameter searchForm: The search form to be managed.
     - Parameter toast: The toast for displaying messages.
     */
    init(searchForm: SearchForm, toast: Toast) {
        self.searchForm = searchForm
        self.toast = toast
    }
    
    /**
     Validates the search form, displaying a toast message if validation fails.

     - Returns: A boolean indicating whether the search form is valid.
     */
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
    
    /**
     Generates a search results query based on the search form.

     - Returns: The generated search results query.
     */
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
    
    /**
     Fetches the current location and updates the search form with the zipcode.
     */
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
    
    /**
     Fetches zipcodes based on user input and updates the search form with fetched zipcodes.
     */
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
    
    /**
     Stores fetched zipcodes in the search form.

     - Parameter zipcodeResponse: The response containing fetched zipcodes.
     */
    func storeFetchedZipcodes(_ zipcodeResponse: ZipcodeResponse) {
        searchForm.fetchedZipcodes = []

        for zipcode in zipcodeResponse.postalCodes {
            if let postalCode = zipcode.postalCode {
                searchForm.fetchedZipcodes.append(postalCode)
            }
        }
    }
    
    /**
      Clears the search form, resetting all fields to their default values.
      */
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
    // Static properties and constants
    
    /// Toast message for mandatory keywords.
    static let madatoryKeywordsText = "Keyword is mandatory"
    
    /// Toast message for mandatory zipcode.
    static let mandatoryZipcodeText = "Zipcode is mandatory"
    
    /// Regular expression for validating zipcodes.
    static let zipcodeRegex = "[0-9]{5,5}"
    
    /// Toast message for invalid zipcodes.
    static let invalidZipcodeText = "Zipcode is invalid"
    
    /// Default distance for search.
    static let defaultDistance = "10"
    
    /// API endpoint for fetching current location.
    static let currentLocationAPI = "http://ip-api.com/json"
    
    /// API endpoint for autocompleting zipcodes.
    static let autoCompleteAPI = "https://csci571-assi3-nikhal-backend.uc.r.appspot.com/autocompleteZipcode?zipcode="
    
    /// Enumeration representing category types.
    enum CategoryType: String {
        case art = "Art"
        case baby = "Baby"
        case books = "Books"
        case clothing = "Clothing,Shoes & Accessories"
        case computers = "Computers/Tablets & Networking"
        case health = "Health & Beauty"
        case music = "Music"
        case videoGames = "Video games & Consoles"
    }
    
    /// Enumeration representing category parameters.
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
    
    /// URL parameter for keywords.
    static let keywordsParameter = "keywords="
    
    /// URL parameter for category type.
    static let categoryTypeParameter = "&categoryType="
    
    /// URL parameter for new condition.
    static let newConditionParameter = "&condition=new"
    
    /// URL parameter for used condition.
    static let usedConditionParameter = "&condition=used"
    
    /// URL parameter for local shipping.
    static let localShippingParameter = "&shipping=local"
    
    /// URL parameter for free shipping.
    static let freeShippingParameter = "&shipping=free"
    
    /// URL parameter for distance.
    static let distanceParameter = "&distance="
    
    /// URL parameter for zipcode.
    static let zipcodeParameter = "&zipcode="
}
