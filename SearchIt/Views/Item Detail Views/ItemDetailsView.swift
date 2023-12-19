/**
 `ItemDetailsView`

 A SwiftUI view to display the details of an item, including information, shipping details, photos, and similar items.

 - Author: Omkar Nikhal
 - Date: 11/23/23
 */
import SwiftUI

struct ItemDetailsView: View {
    
    /// The view model responsible for handling item details.
    @ObservedObject var itemDetailsViewModel: ItemDetailsViewModel
    
    /// The view model responsible for managing wish list items.
    @ObservedObject var wishListViewModel: WishListViewModel
    
    /// The unique identifier of the item.
    var itemID: String
    
    /// The shipping cost of the item.
    var itemShippingCost: String?
    
    var body: some View {
        // TabView for organizing different sections of item details
        TabView {
            // Information Tab
            if itemDetailsViewModel.isItemDetailsLoading {
                ProgressView()
                    .tabItem {
                        Label(Self.infoText, systemImage: Self.infoLogo)
                    }
            } else {
                ItemInfoView(itemDetailsViewModel)
                    .tabItem {
                        Label(Self.infoText, systemImage: Self.infoLogo)
                    }
            }
            
            // Shipping Tab
            ItemShippingView(itemDetailsViewModel, itemShippingCost)
                .tabItem {
                    Label(Self.shippingText, systemImage: Self.shippingLogo)
                }
            
            // Photos Tab
            ItemPhotosView(itemDetailsViewModel)
                .tabItem {
                    Label(Self.photosText, systemImage: Self.photosLogo)
                }
            
            // Similar Items Tab
            SimilarItemsView(itemDetailsViewModel)
                .tabItem {
                    Label(Self.similarText, systemImage: Self.similarLogo)
                }
        }
        .toolbar {
            // Toolbar for additional actions
            ToolbarItem(placement: .topBarTrailing) {
                
                HStack {
                    Spacer()
                    
                    // Facebook Share Button
                    Link(destination: URL(string: Self.facebookURLString+(itemDetailsViewModel.currentItem?.itemURL ?? ""))!, label: {
                        Image(Self.facebookImage)
                            .resizable()
                            .scaledToFit()
                            .frame(height: Self.facebookImageHeight)
                    })
                    
                    // Wish List Heart Button
                    Button(action: {
                        if wishListViewModel.wishListItemIDs.contains(itemDetailsViewModel.currentItem?.itemID ?? "") {
                            wishListViewModel.removeFromWishListItems(itemDetailsViewModel.currentItem?.itemID ?? "", false)
                        } else {
                            wishListViewModel.addWishListItems(itemDetailsViewModel.currentItem?.itemID ?? "", false)
                        }
                    }, label: {
                        Image(systemName: wishListViewModel.wishListItemIDs.contains(itemDetailsViewModel.currentItem?.itemID ?? "")  ? Self.heartFillImage : Self.heartImage)
                            .foregroundStyle(Color.red)
                    })
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            itemDetailsViewModel.getItemDetails(itemID)
        }
    }
}

extension ItemDetailsView {
    static let infoText = "Info"
    static let infoLogo = "info.circle"
    static let shippingText = "Shipping"
    static let shippingLogo = "shippingbox.fill"
    static let photosText = "Photos"
    static let photosLogo = "photo.stack"
    static let similarText = "Similar"
    static let similarLogo = "list.bullet.indent"
    static let facebookURLString = "https://www.facebook.com/sharer/sharer.php?u="
    static let facebookImage = "fb"
    static let heartFillImage = "heart.fill"
    static let heartImage = "heart"
    static let facebookImageHeight = 25.0
}
