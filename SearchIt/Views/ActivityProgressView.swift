//
//  ActivityProgressView.swift
//  CSCI571-Assi4-nikhal
//
//  Created by Omkar Nikhal on 12/4/23.
//

import SwiftUI

struct ActivityProgressView: UIViewRepresentable {
    
    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityProgressView>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
    
    func makeUIView(context: UIViewRepresentableContext<ActivityProgressView>)->UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }
}
