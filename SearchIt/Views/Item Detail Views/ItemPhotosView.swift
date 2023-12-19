//
//  ItemPhotosView.swift
//  CSCI571-Assi4-nikhal
//
//  Created by Omkar Nikhal on 11/23/23.
//

import SwiftUI
import Kingfisher

struct ItemPhotosView: View {
    
    @ObservedObject var itemDetailsViewModel: ItemDetailsViewModel
    @State var showProgressView = true
    
    var body: some View {
        VStack(spacing: 0) {
            if showProgressView {
                ProgressView()
            } else {
                HStack {
                    Text(Self.poweredByText)
                    
                    Image(Self.googleImage)
                        .resizable()
                        .frame(width: Self.googleImageWidth, height: Self.googleImageHeight)
                }
                .padding(.bottom, Self.poweredImageBottomPadding)
                
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
