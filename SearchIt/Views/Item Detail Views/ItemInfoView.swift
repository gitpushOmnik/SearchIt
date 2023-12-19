/**
 `ItemInfoView`

 A SwiftUI view to display detailed information about an item, including pictures, title, price, and item specifics.

 - Author: Omkar Nikhal
 - Date: 11/23/23
 */
import SwiftUI
import Kingfisher

struct ItemInfoView: View {
    
    /// The view model responsible for handling item details.
    @ObservedObject var itemDetailsViewModel: ItemDetailsViewModel
    
    init(_ itemDetailsViewModel: ItemDetailsViewModel) {
        self.itemDetailsViewModel = itemDetailsViewModel
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // TabView for displaying item pictures
            TabView {
                Group {
                    ForEach(itemDetailsViewModel.currentItem?.itemPictureURL ?? [], id: \.self) { itemPictureURL in
                        KFImage.url(URL(string: itemPictureURL))
                            .placeholder{Color.gray}
                            .resizable()
                            .scaledToFit()
                            .tag(itemPictureURL)
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .frame(height: Self.tabViewHeight)
            .padding(.horizontal)
            
            // Display item title
            if let itemTitle = itemDetailsViewModel.currentItem?.itemTitle {
                Text(itemTitle)
                    .multilineTextAlignment(.leading)
                    .padding(.top, Self.titleTopPadding)
                    .padding(.horizontal)
            }
            
            // Display item price
            if let itemPrice = itemDetailsViewModel.currentItem?.itemPrice {
                Text(Self.dollarText + String(format: "%.2f", itemPrice))
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(Color.blue)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .padding(.top, Self.priceTopPadding)
                    .padding(.horizontal)
            }
            
            // Display item specifics
            if let itemSpecifics = itemDetailsViewModel.currentItem?.itemSpecifics {
                HStack {
                    Image(systemName: Self.magnifyingLogo)
                        .multilineTextAlignment(.leading)
                    Text(Self.descriptionText)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                .padding(.top, Self.descriptionTopPadding)
                .padding(.horizontal)
                
                // ScrollView for item specifics
                ScrollView {
                    VStack(spacing: 0) {
                        ForEach(itemSpecifics, id: \.self) { itemSpecific in
                            if let name = itemSpecific.name, let value = itemSpecific.valueString {
                                Divider()
                                    .frame(height: 1)
                                    .overlay(Color(uiColor: UIColor.lightGray))
                                    .offset(y: -3)
                                HStack {
                                    Text(name)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    Text(value)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }
                            }
                        }
                    }
                    .padding(.top, Self.titleTopPadding)
                    .padding(.horizontal)
                }
                .padding(.top, Self.scrollViewTopPadding)
            }
        }
        .padding(.top, Self.infoViewTopPadding)
    }
}

extension ItemInfoView {
    static let magnifyingLogo = "magnifyingglass"
    static let dollarText = "$"
    static let descriptionText = "Description"
    static let tabViewHeight = 200.0
    static let titleTopPadding = 12.0
    static let priceTopPadding = 15.0
    static let descriptionTopPadding = 15.0
    static let scrollViewTopPadding = 25.0
    static let infoViewTopPadding = 60.0
}
