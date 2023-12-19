/**
 `CustomLocationView`

 A SwiftUI view allowing the user to enter a custom location, specifically a zipcode.

 - Author: Omkar Nikhal
 - Date: 11/21/23
 */
import SwiftUI
import Alamofire

struct CustomLocationView: View {
    
    /// Observed object for the search form view model.
    @ObservedObject var searchFormViewModel: SearchFormViewModel
    
    /// State variable to control the presentation of the sheet.
    @State private var isSheetPresented: Bool = false

    /// Initializes a `CustomLocationView` with the provided search form view model.
    /// - Parameter searchFormViewModel: Observed object for the search form view model.
    init(_ searchFormViewModel: SearchFormViewModel) {
        self.searchFormViewModel = searchFormViewModel
    }
    
    var body: some View {
        // Vertical stack for custom location input
        VStack {
            // Horizontal stack for custom location toggle
            HStack {
                Text(Self.customLocationLabel)
                // Toggle for entering custom location
                Toggle("", isOn: $searchFormViewModel.searchForm.enterCustomLocation)
            }
            
            // If custom location is enabled
            if searchFormViewModel.searchForm.enterCustomLocation {
                // Horizontal stack for zipcode input
                HStack {
                    Text(Self.zipcodeLabel)
                    
                    // TextField for zipcode input
                    TextField(
                        Self.requiredPlaceholderText,
                        text: $searchFormViewModel.searchForm.userInputZipcode
                    )
                    // Perform actions when the user input changes
                    .onChange(of: searchFormViewModel.searchForm.userInputZipcode, {
                        // Check if the zipcode input is not empty and less than the maximum count
                        if searchFormViewModel.searchForm.userInputZipcode != "" && searchFormViewModel.searchForm.userInputZipcode.count < Self.zipcodeMaxCount {
                            // Delay fetching zipcodes to reduce API calls
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                                searchFormViewModel.fetchZipcodes()
                            }
                        }
                    })
                }
            }
        }
        // Present a sheet when zipcodes are fetched
        .sheet(isPresented: $searchFormViewModel.searchForm.zipcodeFetched) {
            ZipcodeSheetView($searchFormViewModel.searchForm.userInputZipcode, searchFormViewModel.searchForm.fetchedZipcodes)
        }
    }
}

// MARK: - CustomLocationView Constants
extension CustomLocationView {
    static let customLocationLabel = "Custom Location"
    static let zipcodeLabel = "Zipcode:"
    static let requiredPlaceholderText = "Required"
    static let zipcodeMaxCount = 5
}
