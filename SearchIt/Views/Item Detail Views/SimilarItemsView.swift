/**
 `SimilarItemsView`

 A SwiftUI view to display a list of similar items, allowing users to sort them based on various criteria.

 - Author: Omkar Nikhal
 - Date: 11/23/23
 */
import SwiftUI

struct SimilarItemsView: View {
    
    /// The view model for item details.
    @ObservedObject var itemDetailsViewModel: ItemDetailsViewModel
    
    /// The selected sorting category.
    @State var selectedCategory: SortOption = .default
    
    /// The selected sorting order.
    @State var selectedOrder: SortOrder = .ascending
    
    /// A flag to control the visibility of the progress view.
    @State var showProgressView = true
    
    /// The sorted list of similar items based on the selected sorting category and order.
    var sortedSimilarItems: [SimilarItem] {
        let sortedSimilarItems = itemDetailsViewModel.currentItem?.itemSimilarItems?.sorted(by: selectedCategory.categorySorter)
        if let sortedSimilarItems = sortedSimilarItems {
            return selectedOrder == .ascending ? sortedSimilarItems : sortedSimilarItems.reversed()
        }
        return []
    }
    
    /**
     Initializes a `SimilarItemsView` with the required view model.

     - Parameters:
        - itemDetailsViewModel: The view model for item details.
     */
    init(_ itemDetailsViewModel: ItemDetailsViewModel) {
        self.itemDetailsViewModel = itemDetailsViewModel
    }

    var body: some View {
        VStack(alignment: .leading) {
            if showProgressView {
                // Display a progress view while loading data.
                ProgressView()
            } else {
                if sortedSimilarItems.isEmpty {
                    Text("No similar items")
                } else {
                    Text(Self.sortByText)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    // Picker for sorting category
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
                        
                        // Picker for sorting order
                        Picker("", selection: $selectedOrder) {
                            ForEach(SortOrder.allCases, id: \.self) {
                                Text($0.rawValue)
                            }
                        }
                        .pickerStyle(.segmented)
                        .padding(.horizontal)
                        .padding(.top, Self.orderPickerTopPadding)
                    }
                    
                    // Display similar items in a scrollable grid
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
            // Simulate a delay before hiding the progress view.
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                showProgressView = false
            }
        }
    }
    
    /// Update the order picker when the sorting category changes.
    private func updateOrderPicker() {
        selectedOrder = .ascending
    }
}

extension SimilarItemsView {
    
    /// The text for "Sort By" label.
    static let sortByText = "Sort By"
    
    /// The default text for sorting.
    static let defaultText = "Default"
    
    /// The text for "Order" label.
    static let orderText = "Order"
    
    /// The top padding for "Sort By" section.
    static let sortByTopPadding = 3.0
    
    /// The top padding for "Order" section.
    static let orderTopPadding = 13.0
    
    /// The top padding for the order picker.
    static let orderPickerTopPadding = 6.0
    
    /// The top padding for the scroll view.
    static let scrollViewTopPadding = 15.0
    
    /// The top padding for the entire view.
    static let similarItemsViewTopPadding = 12.0
    
    /// The grid columns for the lazy grid.
    static var columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    /// Enumeration for sorting options.
    enum SortOption: String, CaseIterable {
        case `default` = "Default"
        case name = "Name"
        case price = "Price"
        case daysLeft = "Days Left"
        case shipping = "Shipping"

        /// Closure to determine the sorting order based on the selected option.
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
    
    /// Enumeration for sorting order.
    enum SortOrder: String, CaseIterable {
        case ascending = "Ascending"
        case descending = "Descending"
    }
}
