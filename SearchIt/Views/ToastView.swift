//
//  ToastView.swift
//  CSCI571-Assi4-nikhal
//
//  Created by Omkar Nikhal on 11/20/23.
//

import SwiftUI

extension View {
    func showToast<ToastView>(_ isToastShown: Binding<Bool>, toastMessage: @escaping () -> ToastView) -> some View where ToastView: View {
        CreateToast(parentView: {self}, isToastShown: isToastShown, toastMessage: toastMessage)
    }
}

struct CreateToast<ParentView, ToastView>: View where ParentView: View, ToastView: View {
   
    let parentView: ()->ParentView
    @Binding var isToastShown: Bool
    let toastMessage: ()->ToastView

    var body: some View {
        if self.isToastShown {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                self.isToastShown = false
            }
        }

        return GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                parentView()

                ZStack {
                    toastMessage()
                        .foregroundColor(.white)
                        .padding(20)
                        .background {
                            RoundedRectangle(cornerRadius: 12)
                            .fill(Color.black)
                        }
                }
                .offset(y: -45)
                .opacity(self.isToastShown ? 1 : 0)
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}
