/**
 `DistanceView`

 A SwiftUI view allowing the user to enter the search distance.

 - Author: Omkar Nikhal
 - Date: 11/21/23
 */
import SwiftUI

struct DistanceView: View {
    
    /// Binding for the search distance input.
    @Binding var distance: String
    
    /// Initializes a `DistanceView` with the provided binding for distance.
    /// - Parameter distance: Binding for the search distance input.
    init(_ distance: Binding<String>) {
        self._distance = distance
    }
    
    var body: some View {
        // Horizontal stack for distance input
        HStack {
            Text(Self.distanceLabel)
            
            // TextField for entering search distance
            TextField(
                Self.distancePlaceholder,
                text: $distance
            )
        }
    }
}

// MARK: - DistanceView Constants
extension DistanceView {
    static let distanceLabel = "Distance:"
    static let distancePlaceholder = "10"
}
