//
//  SimilarItemsView.swift
//  CSCI571-Assi4-nikhal
//
//  Created by Omkar Nikhal on 11/23/23.
//

import SwiftUI
import Kingfisher

struct SimilarItemsView: View {
    
    @ObservedObject var itemDetailsViewModel: ItemDetailsViewModel
    @State var selectedCategory: SortOption = .default
    @State var selectedOrder: SortOrder = .ascending
    @State var showProgressView = true
    
    var sortedSimilarItems: [SimilarItem] {
        let sortedSimilarItems = itemDetailsViewModel.currentItem?.itemSimilarItems?.sorted(by: selectedCategory.categorySorter)
        if let sortedSimilarItems = sortedSimilarItems {
            return selectedOrder == .ascending ? sortedSimilarItems : sortedSimilarItems.reversed()
        }
        return []
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            if showProgressView {
                ProgressView()
            } else {
                if sortedSimilarItems.isEmpty {
                    Text("No similar items")
                } else {
                    Text(Self.sortByText)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    Picker("", selection: $selectedCategory) {
                        ForEach(SortOption.allCases, id: \.self) { option in
                            Text(option.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding(.horizontal)
                    .padding(.top, Self.sortByTopPadding)
                    .onChange(of: selectedCategory) {
                        selectedOrder = .ascending 
                    }
                    
                    if selectedCategory.rawValue != Self.defaultText {
                        Text(Self.orderText)
                            .font(.body)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, Self.orderTopPadding)
                            .padding(.horizontal)
                        
                        Picker("", selection: $selectedOrder) {
                            ForEach(SortOrder.allCases, id: \.self) {
                                Text($0.rawValue)
                            }
                        }
                        .pickerStyle(.segmented)
                        .padding(.horizontal)
                        .padding(.top, Self.orderPickerTopPadding)
                    }
                    
                    ScrollView {
                        LazyVGrid(columns: Self.columns, spacing: 10) {
                            ForEach(sortedSimilarItems) { similarItem in
                                SimilarItemCardView(similarItem)
                            }
                        }
                    }
                    .padding(.top, Self.scrollViewTopPadding)
                }
            }
        }
        .padding(.top, Self.similarItemsViewTopPadding)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                showProgressView = false
            }
        }
    }
    
    private func updateOrderPicker() {
        selectedOrder = .ascending
    }
}

extension SimilarItemsView {
    
    static let sortByText = "Sort By"
    static let defaultText = "Default"
    static let orderText = "Order"
    static let sortByTopPadding = 3.0
    static let orderTopPadding = 13.0
    static let orderPickerTopPadding = 6.0
    static let scrollViewTopPadding = 15.0
    static let similarItemsViewTopPadding = 12.0
    
    static var columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    enum SortOption: String, CaseIterable {
        case `default` = "Default"
        case name = "Name"
        case price = "Price"
        case daysLeft = "Days Left"
        case shipping = "Shipping"

        var categorySorter: (SimilarItem, SimilarItem) -> Bool {
            switch self {
                case .default: return { $0.itemIndex ?? 0 < $1.itemIndex ?? 0 }
                case .name: return { $0.itemTitle ?? "" < $1.itemTitle ?? "" }
                case .price: return { $0.itemPrice ?? 0.0 < $1.itemPrice ?? 0.0 }
                case .daysLeft: return { $0.itemDaysLeft ?? 0 < $1.itemDaysLeft ?? 0 }
                case .shipping: return { $0.itemShippingCost ?? 0.0 < $1.itemShippingCost ?? 0.0 }
            }
        }
    }
    
    enum SortOrder: String, CaseIterable {
        case ascending = "Ascending"
        case descending = "Descending"
    }
}
