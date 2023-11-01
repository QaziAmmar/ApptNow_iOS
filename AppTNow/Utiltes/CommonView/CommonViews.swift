//
//  CommonViews.swift
//  AppTNowEmplyee
//
//  Created by Qazi Mudassar on 31/08/2023.
//

import SwiftUI

struct RectangleImageView: View {
    let image: String
    var width: CGFloat = 50
    var height: CGFloat = 50
    
    var body: some View {
        Rectangle()
            .foregroundColor(.clear)
            .frame(width: width, height: height)
            .background(
                Image(systemName: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: width, height: height)
                    .clipped()
            )
            .cornerRadius(9)
            .overlay(
                RoundedRectangle(cornerRadius: 9)
                    .stroke(Color(red: 0.97, green: 0.97, blue: 0.97), lineWidth: 2)
            )
    }
}
struct RectangleAysnImageView: View {
    let url: String
    var width: CGFloat = 50
    var height: CGFloat = 50
    
    var body: some View {
        Rectangle()
            .foregroundColor(.clear)
            .frame(width: width, height: height)
            .background(
                AsyncImageView(url:
                                URL(string: AppUrl.IMAGEURL + (url))!,
                               placeHolder: ImageName.Common.thumb,
                               width: width,
                               height: height)
                .clipped()
            )
            .cornerRadius(9)
            .overlay(
                RoundedRectangle(cornerRadius: 9)
                    .stroke(Color(red: 0.97, green: 0.97, blue: 0.97), lineWidth: 2)
            )
    }
}


struct CircularAsyncImageView: View {
    let url: String
    var size: CGFloat = 50
    
    var body: some View {
        AsyncImageView(url: URL(string: AppUrl.IMAGEURL + url)!,
                       placeHolder: ImageName.Common.thumb,
                       width: size,
                       height: size)
            .clipShape(Circle())
            .frame(width: size, height: size)
            .overlay(
                Circle()
                    .stroke(Color(red: 0.97, green: 0.97, blue: 0.97), lineWidth: 2)
            )
    }
}
