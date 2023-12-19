/**
 `SearchForm`

 A data structure representing the search form with user input.

 - Author: Omkar Nikhal
 - Date: 11/20/23
 */
import Foundation

struct SearchForm {
    
    /// The user-inputted keywords for the search.
    var keywords: String = ""
    
    /// The selected category type for the search.
    var categoryType: String = "All"
    
    /// Indicates whether new condition is selected in the search form.
    var newCondition: Bool = false
    
    /// Indicates whether used condition is selected in the search form.
    var usedCondition: Bool = false
    
    /// Indicates whether unspecified condition is selected in the search form.
    var unspecifiedCondition: Bool = false
    
    /// Indicates whether local shipping is selected in the search form.
    var localShipping: Bool = false
    
    /// Indicates whether free shipping is selected in the search form.
    var freeShipping: Bool = false
    
    /// The distance parameter for the search.
    var distance: String = ""
    
    /// Indicates whether the user has entered a custom location for the search.
    var enterCustomLocation: Bool = false
    
    /// Indicates whether the search form is valid.
    var isFormValid: Bool = false
    
    /// The current location's ZIP code.
    var currentLocationZipcode: String = "90007"
    
    /// The user-inputted ZIP code for custom location search.
    var userInputZipcode: String = ""
    
    /// The list of fetched ZIP codes based on user input.
    var fetchedZipcodes: [String] = []
    
    /// Indicates whether ZIP codes have been fetched.
    var zipcodeFetched: Bool = false
}
