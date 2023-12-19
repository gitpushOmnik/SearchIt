//
//  CustomLocationView.swift
//  CSCI571-Assi4-nikhal
//
//  Created by Omkar Nikhal on 11/21/23.
//

import SwiftUI
import Alamofire

struct CustomLocationView: View {
    
    @ObservedObject var searchFormViewModel: SearchFormViewModel
    @State private var isSheetPresented: Bool = false

    init(_ searchFormViewModel: SearchFormViewModel) {
        self.searchFormViewModel = searchFormViewModel
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(Self.customLocationLabel)
                Toggle("", isOn: $searchFormViewModel.searchForm.enterCustomLocation)
            }
            
            if searchFormViewModel.searchForm.enterCustomLocation {
                HStack {
                    Text(Self.zipcodeLabel)
                    
                    TextField(
                        Self.requiredPlaceholderText,
                        text: $searchFormViewModel.searchForm.userInputZipcode
                    )
                    .onChange(of: searchFormViewModel.searchForm.userInputZipcode, {
                        if searchFormViewModel.searchForm.userInputZipcode != "" && searchFormViewModel.searchForm.userInputZipcode.count < Self.zipcodeMaxCount {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                                searchFormViewModel.fetchZipcodes()
                            }
                        }
                    })
                }
            }
        }
        .sheet(isPresented: $searchFormViewModel.searchForm.zipcodeFetched) {
            ZipcodeSheetView($searchFormViewModel.searchForm.userInputZipcode, searchFormViewModel.searchForm.fetchedZipcodes)
        }
    }
}

extension CustomLocationView {
    static let customLocationLabel = "Custom Location"
    static let zipcodeLabel = "Zipcode:"
    static let requiredPlaceholderText = "Required"
    static let zipcodeMaxCount = 5
}
