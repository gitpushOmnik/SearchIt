//
//  FormButtonsView.swift
//  CSCI571-Assi4-nikhal
//
//  Created by Omkar Nikhal on 11/21/23.
//

import SwiftUI

struct FormButtonsView: View {
    
    @ObservedObject var searchFormViewModel: SearchFormViewModel
    @ObservedObject var searchResultsViewModel: SearchResultsViewModel
        
    init(_ searchFormViewModel: SearchFormViewModel, _ searchResultsViewModel: SearchResultsViewModel) {
        self.searchFormViewModel = searchFormViewModel
        self.searchResultsViewModel = searchResultsViewModel
    }
    
    var body: some View {
        HStack {
            Spacer()
            
            Button(action: {
                if searchFormViewModel.validateSearchForm() {
                    let searchQueryString = searchFormViewModel.generateSearchResultsQuery()
                    searchResultsViewModel.getSearchResultItems(searchQueryString)
                }
            }){
                Text(Self.submitLabel)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: Self.buttonWidth, height: Self.buttonHeight)
            }
            .buttonStyle(.borderless)
            .background(Color.blue)
            .cornerRadius(Self.buttonCornerRadius)
            
            Spacer()
            
            Button(action: {
                searchFormViewModel.clearForm()
                searchResultsViewModel.clearSearchResults()
            }){
                Text(Self.clearLabel)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: Self.buttonWidth, height: Self.buttonHeight)
            }
            .buttonStyle(.plain)
            .background(Color.blue)
            .cornerRadius(Self.buttonCornerRadius)
            
            Spacer()
        }
    }
}

extension FormButtonsView {
    static let submitLabel = "Submit"
    static let clearLabel = "Clear"
    static let buttonWidth = 110.0
    static let buttonHeight = 55.0
    static let buttonCornerRadius = 10.0
}
