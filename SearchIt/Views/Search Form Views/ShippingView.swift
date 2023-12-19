//
//  ShippingView.swift
//  CSCI571-Assi4-nikhal
//
//  Created by Omkar Nikhal on 11/21/23.
//

import SwiftUI

struct ShippingView: View {
    
    @Binding var localShipping: Bool
    @Binding var freeShipping: Bool
    
    init(_ localShipping: Binding<Bool>, _ freeShipping: Binding<Bool>) {
        self._localShipping = localShipping
        self._freeShipping = freeShipping
    }
    
    var body: some View {
        VStack() {
            Text(Self.shippingLabel)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, Self.shippingVerticalPadding)
            
            HStack {
                
                Spacer()
                
                HStack {
                    Image(systemName: localShipping ? Self.filledCheckmark : Self.emptySquare)
                        .foregroundColor(localShipping ? Color(UIColor.systemBlue) : Color.secondary)
                        .onTapGesture {
                            localShipping.toggle()
                        }
                    Text(Self.pickupLabel)
                }
                
                Spacer()
                
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
