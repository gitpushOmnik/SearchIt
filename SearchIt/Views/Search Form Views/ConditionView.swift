//
//  ConditionView.swift
//  CSCI571-Assi4-nikhal
//
//  Created by Omkar Nikhal on 11/21/23.
//

import SwiftUI

struct ConditionView: View {
    
    @Binding var newCondition: Bool
    @Binding var usedCondition: Bool
    @Binding var unspecifiedCondition: Bool
    
    init(_ newCondition: Binding<Bool>, _ usedCondition: Binding<Bool>, _ unspecifiedCondition: Binding<Bool>) {
        self._newCondition = newCondition
        self._usedCondition = usedCondition
        self._unspecifiedCondition = unspecifiedCondition
    }
    
    var body: some View {
        VStack(){
            Text(Self.conditionLabel)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, Self.conditionVerticalPadding)
            
            HStack {
            
                Spacer()
                
                HStack {
                    Image(systemName: usedCondition ? Self.filledCheckmark : Self.emptySquare)
                        .foregroundColor(usedCondition ? Color(UIColor.systemBlue) : Color.secondary)
                        .onTapGesture {
                            usedCondition.toggle()
                        }
                    Text(Self.usedLabel)
                }
                
                Spacer()
                
                HStack {
                    Image(systemName: newCondition ? Self.filledCheckmark : Self.emptySquare)
                        .foregroundColor(newCondition  ? Color(UIColor.systemBlue) : Color.secondary)
                        .onTapGesture {
                            newCondition.toggle()
                        }
                    Text(Self.newLabel)
                }
                
                Spacer()
                
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

