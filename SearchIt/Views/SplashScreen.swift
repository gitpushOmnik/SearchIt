/**
 `SplashScreen`

 A splash screen displayed before transitioning to the main search form view.

 - Author: Omkar Nikhal
 - Date: 11/19/23
 */
import SwiftUI

struct SplashScreen: View {
    
    /// State to track whether the main screen is active.
    @State var isMainScreenActive = false
    
    /// The body of the SplashScreen.
    var body: some View {
        ZStack {
            if self.isMainScreenActive {
                // Display the main search form view when active
                SearchFormView()
            } else {
                // Display the splash screen with text and logo
                HStack {
                    Text(Self.splashScreenText)
                    Image(Self.logoImageName)
                        .resizable()
                        .frame(width: Self.splashScreenWidth, height: Self.splashScreenHeight)
                }
            }
        }
        .onAppear {
            // Simulate a delay before transitioning to the main screen
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.isMainScreenActive = true
            }
        }
    }
}

// MARK: - SplashScreen Constants
extension SplashScreen {
    static let splashScreenText = "Powered by"
    static let logoImageName = "logo"
    static let splashScreenWidth = 100.0
    static let splashScreenHeight = 45.0
}

// MARK: - SplashScreen Preview
struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
