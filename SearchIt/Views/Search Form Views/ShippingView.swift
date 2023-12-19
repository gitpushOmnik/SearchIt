/**
 `ShippingView`

 A SwiftUI view to customize shipping options.

 - Author: Omkar Nikhal
 - Date: 11/21/23
 */
import SwiftUI

struct ShippingView: View {
    
    /// Binding for local shipping option.
    @Binding var localShipping: Bool
    
    /// Binding for free shipping option.
    @Binding var freeShipping: Bool
    
    /// Initializes a `ShippingView` with the provided bindings for local and free shipping.
    /// - Parameters:
    ///   - localShipping: Binding for local shipping option.
    ///   - freeShipping: Binding for free shipping option.
    init(_ localShipping: Binding<Bool>, _ freeShipping: Binding<Bool>) {
        self._localShipping = localShipping
        self._freeShipping = freeShipping
    }
    
    var body: some View {
        // Main content of the ShippingView
        VStack() {
            Text(Self.shippingLabel)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, Self.shippingVerticalPadding)
            
            // Shipping options
            HStack {
                Spacer()
                
                // Local pickup option
                HStack {
                    Image(systemName: localShipping ? Self.filledCheckmark : Self.emptySquare)
                        .foregroundColor(localShipping ? Color(UIColor.systemBlue) : Color.secondary)
                        .onTapGesture {
                            localShipping.toggle()
                        }
                    Text(Self.pickupLabel)
                }
                
                Spacer()
                
                // Free shipping option
                HStack {
                    Image(systemName: freeShipping ? Self.filledCheckmark : Self.emptySquare)
                        .foregroundColor(freeShipping  ? Color(UIColor.systemBlue) : Color.secondary)
                        .onTapGesture {
                            freeShipping.toggle()
                        }
                    Text(Self.freeShippingLabel)
                }
                
                Spacer()
            }
            .padding(.top, Self.shippingTopPadding)
            .padding(.bottom, Self.shippingBottomPadding)
        }
    }
}

// MARK: - ShippingView Constants
extension ShippingView {
    static let shippingLabel = "Shipping"
    static let filledCheckmark = "checkmark.square.fill"
    static let emptySquare = "square"
    static let pickupLabel = "Pickup"
    static let freeShippingLabel = "Free Shipping"
    static let shippingVerticalPadding = 5.0
    static let shippingTopPadding = 4.0
    static let shippingBottomPadding = 3.0
}
