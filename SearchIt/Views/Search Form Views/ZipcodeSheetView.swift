/**
 `ZipcodeSheetView`

 A sheet view displaying pincode suggestions based on user input.

 - Author: Omkar Nikhal
 - Date: 12/3/23
 */
import SwiftUI

struct ZipcodeSheetView: View {
    
    /// The environment presentation mode for dismissing the sheet.
    @Environment(\.presentationMode) var presentationMode
    
    /// Binding to the selected zipcode.
    @Binding var selectedZipcode: String
    
    /// Array of zipcodes for suggestions.
    var zipcodes: [String]

    /// Initializes the ZipcodeSheetView.
    init(_ selectedZipcode: Binding<String>, _ zipcodes: [String]) {
        self._selectedZipcode = selectedZipcode
        self.zipcodes = zipcodes
    }
    
    /// The body of the ZipcodeSheetView.
    var body: some View {
        // Vertical stack containing text and a list of zipcodes
        VStack {
            Text(Self.pincodeSuggestion)
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, Self.pincodeTextTopPadding)
                .padding(.bottom, Self.pincodeTextBottomPadding)
            
            // List of buttons representing each suggested zipcode
            List(zipcodes, id: \.self) { zipcode in
                Button(action: {
                    // Update the selected zipcode and dismiss the sheet
                    selectedZipcode = zipcode
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text(zipcode)
                        .foregroundStyle(Color.black)
                }
            }
        }
    }
}

// MARK: - ZipcodeSheetView Constants
extension ZipcodeSheetView {
    static let pincodeSuggestion = "Pincode suggestions"
    static let pincodeTextTopPadding = 17.0
    static let pincodeTextBottomPadding = 20.0
}
