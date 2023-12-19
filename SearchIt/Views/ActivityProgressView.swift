/**
 `ActivityProgressView`

 A SwiftUI view representing an activity progress indicator.

 - Author: Omkar Nikhal
 - Date: 12/4/23
 */
import SwiftUI

struct ActivityProgressView: UIViewRepresentable {
    
    /// Binding to control the animation state of the activity indicator.
    @Binding var isAnimating: Bool
    
    /// The style of the activity indicator.
    let style: UIActivityIndicatorView.Style

    /// Updates the state of the UIKit view.
    /// - Parameters:
    ///   - uiView: The UIKit view being updated.
    ///   - context: The context for coordinating with the SwiftUI runtime.
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityProgressView>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
    
    /// Creates a `UIActivityIndicatorView` and returns it.
    /// - Parameter context: The context for creating the view.
    /// - Returns: A new `UIActivityIndicatorView`.
    func makeUIView(context: UIViewRepresentableContext<ActivityProgressView>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }
}
