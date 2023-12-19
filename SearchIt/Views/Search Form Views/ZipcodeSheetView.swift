//
//  ZipcodeSheetView.swift
//  CSCI571-Assi4-nikhal
//
//  Created by Omkar Nikhal on 12/3/23.
//

import SwiftUI

struct ZipcodeSheetView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedZipcode: String
    var zipcodes: [String]

    init(_ selectedZipcode: Binding<String>, _ zipcodes: [String]) {
        self._selectedZipcode = selectedZipcode
        self.zipcodes = zipcodes
    }
    
    var body: some View {
        VStack {
            Text(Self.pincodeSuggestion)
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, Self.pincodeTextTopPadding)
                .padding(.bottom, Self.pincodeTextBottomPadding)
            
            List(zipcodes, id: \.self) { zipcode in
                Button(action: {
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

extension ZipcodeSheetView {
    static let pincodeSuggestion = "Pincode suggestions"
    static let pincodeTextTopPadding = 17.0
    static let pincodeTextBottomPadding = 20.0
}

