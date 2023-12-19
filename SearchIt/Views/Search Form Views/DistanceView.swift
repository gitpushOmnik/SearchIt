//
//  DistanceView.swift
//  CSCI571-Assi4-nikhal
//
//  Created by Omkar Nikhal on 11/21/23.
//

import SwiftUI

struct DistanceView: View {
    
    @Binding var distance: String
    
    init(_ distance: Binding<String>) {
        self._distance = distance
    }
    
    var body: some View {
        HStack {
            Text(Self.distanceLabel)
            
            TextField(
                Self.distancePlaceholder,
                text: $distance 
            )
        }
    }
}

extension DistanceView {
    static let distanceLabel = "Distance:"
    static let distancePlaceholder = "10"
}

