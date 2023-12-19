/**
 `ItemShippingView`

 A SwiftUI view to display various shipping details for an item, including seller information, shipping cost, and return policy.

 - Author: Omkar Nikhal
 - Date: 11/23/23
 */
import SwiftUI

struct ItemShippingView: View {
    
    /// The view model for item details.
    @ObservedObject var itemDetailsViewModel: ItemDetailsViewModel
    
    /// The shipping cost for the item.
    var itemShippingCost: String?
    
    /// A flag to control the visibility of the progress view.
    @State var showProgressView = true

    /**
     Initializes an `ItemShippingView` with the required view model and optional shipping cost.

     - Parameters:
        - itemDetailsViewModel: The view model for item details.
        - itemShippingCost: The shipping cost for the item (optional).
     */
    init(_ itemDetailsViewModel: ItemDetailsViewModel, _ itemShippingCost: String?) {
        self.itemDetailsViewModel = itemDetailsViewModel
        self.itemShippingCost = itemShippingCost
    }

    var body: some View {
        VStack {
            if showProgressView {
                // Display a progress view while loading data.
                ProgressView()
            } else {
                VStack(alignment: .leading, spacing: 0) {
                    // Display seller information.
                    ItemSellerView(itemDetailsViewModel)
                    
                    // Display shipping cost and details.
                    ItemShippingCostView(itemDetailsViewModel, itemShippingCost)
                    
                    // Display return policy details.
                    ItemReturnsView(itemDetailsViewModel)
                    
                    Spacer()
                }
                .padding(.top, Self.itemShippingViewTopPadding)
            }
        }
        .onAppear {
            // Simulate a delay before hiding the progress view.
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                showProgressView = false
            }
        }
    }
}

extension ItemShippingView {
    /// The top padding for the item shipping view.
    static let itemShippingViewTopPadding = 60.0
}
