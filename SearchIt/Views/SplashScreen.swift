//
//  SplashScreen.swift
//  CSCI571-Assi4-nikhal
//
//  Created by Omkar Nikhal on 11/19/23.
//

import SwiftUI

struct SplashScreen: View {
    @State var isMainScreenActive = false
    
    var body: some View {
        ZStack {
            if self.isMainScreenActive {
                SearchFormView()
            } else {
                HStack {
                    Text(Self.splashScreenText)
                    Image(Self.logoImageName)
                        .resizable()
                        .frame(width: Self.splashScreenWidth, height: Self.splashScreenHeight)
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.isMainScreenActive = true
            }
        }
    }
}

extension SplashScreen {
    static let splashScreenText = "Powered by"
    static let logoImageName = "logo"
    static let splashScreenWidth = 100.0
    static let splashScreenHeight = 45.0
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
