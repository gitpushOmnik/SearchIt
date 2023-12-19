/**
 `ItemPhotosView`

 A SwiftUI view to display photos of an item, including images powered by Google.

 - Author: Omkar Nikhal
 - Date: 11/23/23
 */
import SwiftUI
import Kingfisher

struct ItemPhotosView: View {
    
    /// The view model responsible for handling item details.
    @ObservedObject var itemDetailsViewModel: ItemDetailsViewModel
    
    /// A boolean indicating whether to show the progress view.
    @State var showProgressView = true
    
    init(_ itemDetailsViewModel: ItemDetailsViewModel) {
        self.itemDetailsViewModel = itemDetailsViewModel
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Show progress view while loading
            if showProgressView {
                ProgressView()
            } else {
                // Display powered by Google text and logo
                HStack {
                    Text(Self.poweredByText)
                    
                    Image(Self.googleImage)
                        .resizable()
                        .frame(width: Self.googleImageWidth, height: Self.googleImageHeight)
                }
                .padding(.bottom, Self.poweredImageBottomPadding)
                
                // Display Google-powered item photos
                VStack(spacing: 0) {
                    ScrollView {
                        ForEach(itemDetailsViewModel.currentItem?.itemGooglePhotos ?? [], id:\.self) { itemPictureURL in
                            KFImage.url(URL(string: itemPictureURL.link ?? ""))
                                .placeholder{Color.gray}
                                .resizable()
                                .scaledToFit()
                                .frame(height: Self.imageHeight, alignment: .center)
                                .frame(maxWidth: .infinity)
                                .tag(itemPictureURL.link)
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
            }
        }
        .padding(.top, Self.itemPhotosViewTopPadding)
        .padding(.horizontal)
        .onAppear {
            // Hide progress view after a short delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                showProgressView = false
            }
        }
    }
}

extension ItemPhotosView {
    static let poweredByText = "Powered by "
    static let googleImage = "google"
    static let googleImageWidth = 95.0
    static let googleImageHeight = 34.0
    static let poweredImageBottomPadding = 20.0
    static let imageHeight = 210.0
    static let itemPhotosViewTopPadding = 50.0
}
