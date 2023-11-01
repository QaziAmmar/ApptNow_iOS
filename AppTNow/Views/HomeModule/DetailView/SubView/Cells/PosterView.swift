//
//  PosterView.swift
//  AppTNow
//
//  Created by Qazi Mudassar on 19/08/2023.
//

import SwiftUI

struct PosterView: View {
    let width: CGFloat = 125
    let height: CGFloat = 125
    let alpha: CGFloat = 0.45
    let url: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Rectangle()
                .foregroundColor(.clear)
                .background(
                    AsyncImageView(url:
                                    URL(string: AppUrl.IMAGEURL + (url))!,
                                   placeHolder: ImageName.Common.thumb,
                                   width: width,
                                   height: height)
                )
                .cornerRadius(5)
        }
        .frame(width: width, height: height)
    }
}
#if DEBUG
struct PosterView_Previews: PreviewProvider {
    static var previews: some View {
        PosterView(url: "")
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
#endif
