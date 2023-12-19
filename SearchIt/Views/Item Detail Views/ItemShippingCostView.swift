/**
 `ItemShippingCostView`

 A SwiftUI view to display shipping information for an item, including shipping cost, global shipping availability, and handling time.

 - Author: Omkar Nikhal
 - Date: 12/5/23
 */
import SwiftUI

struct ItemShippingCostView: View {
    
    /// The view model for item details.
    @ObservedObject var itemDetailsViewModel: ItemDetailsViewModel
    
    /// The shipping cost for the item.
    var itemShippingCost: String?
    
    /**
     Initializes an `ItemShippingCostView` with the required view model and optional shipping cost.

     - Parameters:
        - itemDetailsViewModel: The view model for item details.
        - itemShippingCost: The shipping cost for the item (optional).
     */
    init(_ itemDetailsViewModel: ItemDetailsViewModel, _ itemShippingCost: String? = nil) {
        self.itemDetailsViewModel = itemDetailsViewModel
        self.itemShippingCost = itemShippingCost
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Divider()
                .frame(height: 1)
                .overlay(Color(uiColor: UIColor.lightGray))
            
            HStack {
                Image(systemName: Self.shippingLogo)
                    .font(.body)
                Text(Self.shippingText)
            }
            .padding(.top, Self.shippingTopPadding)
            .padding(.bottom, Self.shippingBottomPadding)
            
            Divider()
                .frame(height: 1)
                .overlay(Color(uiColor: UIColor.lightGray))
            
            VStack(spacing: 6) {
                if let shippingCost = itemShippingCost {
                    HStack {
                        Text(Self.shippingCostText)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity)
                        
                        Text(shippingCost == Self.freeShippingCapitalized ? Self.freeShippingText : shippingCost.replacingOccurrences(of: Self.dollarText, with: ""))
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity)
                    }
                }
                
                if let globalShipping = itemDetailsViewModel.currentItem?.itemGlobalShipping {
                    HStack {
                        Text(Self.globalShippingText)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity)
                        
                        Text(globalShipping ? Self.yesText : Self.noText)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity)
                    }
                }
                
                if let handlingTime = itemDetailsViewModel.currentItem?.itemHandlingTime {
                    HStack {
                        Text(Self.handlingTimeText)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity)
                        
                        Text(String(handlingTime) + (handlingTime <= 1 ? Self.dayText : Self.daysText))
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity)
                    }
                    .padding(.bottom, Self.handlingBottomPadding)
                }
            }
            .padding(.vertical, Self.itemShippingCostViewVerticalPadding)
        }
    }
}

extension ItemShippingCostView {
    /// The shipping logo image name.
    static let shippingLogo = "sailboat"
    
    /// The text indicating shipping information.
    static let shippingText = "Shipping Info"
    
    /// The text indicating shipping cost.
    static let shippingCostText = "Shipping Cost"
    
    /// The text indicating free shipping.
    static let freeShippingText = "FREE"
    
    /// The text indicating free shipping in capital letters.
    static let freeShippingCapitalized = "FREE SHIPPING"
    
    /// The text indicating global shipping availability.
    static let globalShippingText = "Global Shipping"
    
    /// The text indicating "Yes" for global shipping availability.
    static let yesText = "Yes"
    
    /// The text indicating "No" for global shipping availability.
    static let noText = "No"
    
    /// The text indicating handling time.
    static let handlingTimeText = "Handling Time"
    
    /// The text indicating a single day for handling time.
    static let dayText = " day"
    
    /// Dollar Currency
    static let dollarText = "$"
    
    /// The text indicating multiple days for handling time.
    static let daysText = " days"
    
    /// The top padding for the shipping information section.
    static let shippingTopPadding = 10.0
    
    /// The bottom padding for the shipping information section.
    static let shippingBottomPadding = 15.0
    
    /// The bottom padding for the handling time section.
    static let handlingBottomPadding = 8.0
    
    /// The vertical padding for the item shipping cost view.
    static let itemShippingCostViewVerticalPadding = 9.0
}
