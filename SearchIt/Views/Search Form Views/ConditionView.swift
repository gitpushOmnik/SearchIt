/**
 `ConditionView`

 A SwiftUI view to select the condition of an item.

 - Author: Omkar Nikhal
 - Date: 11/21/23
 */
import SwiftUI

struct ConditionView: View {
    
    /// Binding for the 'Used' condition.
    @Binding var usedCondition: Bool
    
    /// Binding for the 'New' condition.
    @Binding var newCondition: Bool
    
    /// Binding for the 'Unspecified' condition.
    @Binding var unspecifiedCondition: Bool
    
    /// Initializes a `ConditionView` with the provided bindings for conditions.
    /// - Parameters:
    ///   - newCondition: Binding for the 'New' condition.
    ///   - usedCondition: Binding for the 'Used' condition.
    ///   - unspecifiedCondition: Binding for the 'Unspecified' condition.
    init(_ newCondition: Binding<Bool>, _ usedCondition: Binding<Bool>, _ unspecifiedCondition: Binding<Bool>) {
        self._newCondition = newCondition
        self._usedCondition = usedCondition
        self._unspecifiedCondition = unspecifiedCondition
    }
    
    var body: some View {
        // Main content of the ConditionView
        VStack() {
            Text(Self.conditionLabel)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, Self.conditionVerticalPadding)
            
            // Horizontal stack for condition options
            HStack {
                Spacer()
                
                // 'Used' condition option
                HStack {
                    Image(systemName: usedCondition ? Self.filledCheckmark : Self.emptySquare)
                        .foregroundColor(usedCondition ? Color(UIColor.systemBlue) : Color.secondary)
                        .onTapGesture {
                            usedCondition.toggle()
                        }
                    Text(Self.usedLabel)
                }
                
                Spacer()
                
                // 'New' condition option
                HStack {
                    Image(systemName: newCondition ? Self.filledCheckmark : Self.emptySquare)
                        .foregroundColor(newCondition  ? Color(UIColor.systemBlue) : Color.secondary)
                        .onTapGesture {
                            newCondition.toggle()
                        }
                    Text(Self.newLabel)
                }
                
                Spacer()
                
                // 'Unspecified' condition option
                HStack {
                    Image(systemName: unspecifiedCondition ? Self.filledCheckmark : Self.emptySquare)
                        .foregroundColor(unspecifiedCondition ? Color(UIColor.systemBlue) : Color.secondary)
                        .onTapGesture {
                            unspecifiedCondition.toggle()
                        }
                    Text(Self.unspecifiedLabel)
                }
                
                Spacer()
            }
            .padding(.top, Self.conditionTopPadding)
            .padding(.bottom, Self.conditionBottomPadding)
        }
    }
}

// MARK: - ConditionView Constants
extension ConditionView {
    static let conditionLabel = "Condition"
    static let filledCheckmark = "checkmark.square.fill"
    static let emptySquare = "square"
    static let usedLabel = "Used"
    static let newLabel = "New"
    static let unspecifiedLabel = "Unspecified"
    static let conditionVerticalPadding = 5.0
    static let conditionTopPadding = 4.0
    static let conditionBottomPadding = 3.0
}
