//
//  AsyncImageView.swift
//  AppTNow
//
//  Created by Qazi Mudassar on 19/08/2023.
//

import SwiftUI

// Updated by Ammar
// below this stuctu you will find the old verison of the AsyncImageView
struct AsyncImageViewUpdated: View {
    
    private let url: URL
    private let placeHolder: ImageName.Common
    
    
    init(url: String, placeHolder: ImageName.Common) {
        self.url = URL(string: AppUrl.IMAGEURL +  url) ?? URL(string: "www.google.com")!
        self.placeHolder = placeHolder
    }
    
    var body: some View {
        
        CacheAsyncImage(
            url: url,
            transaction: Transaction(animation: .easeInOut(duration: 2.5))
        ) { phase in
            switch phase {
            case .empty:
                imagePerView(image: placeHolder.thumbImage)
                    
            case .success(let image):
                imagePerView(image: image)
                    
            case .failure:
                imagePerView(image: placeHolder.thumbImage)
                
            @unknown default:
                EmptyView()
            }
        }
        
    }
    
    func imagePerView(image: Image) -> some View {
        image
            .resizable()
            
            .aspectRatio(contentMode: .fill)
            .foregroundColor(.white)
            
    }
}

// the issue with this view is that you need to add height and widht of image view each time so I have
struct AsyncImageView: View {
    
    private let url: URL
    private let placeHolder: ImageName.Common
    private let width: CGFloat
    private let height: CGFloat
    
    init(url: URL, placeHolder: ImageName.Common, width: CGFloat, height: CGFloat) {
        self.url = url
        self.placeHolder = placeHolder
        self.width = width
        self.height = height
    }
    
    var body: some View {
        
        CacheAsyncImage(
            url: url,
            transaction: Transaction(animation: .easeInOut(duration: 2.5))
        ) { phase in
            switch phase {
            case .empty:
                imagePerView(image: placeHolder.thumbImage)
                
            case .success(let image):
                imagePerView(image: image)
                
            case .failure:
                imagePerView(image: placeHolder.thumbImage)
                
            @unknown default:
                EmptyView()
            }
        }
    }
    
    func imagePerView(image: Image) -> some View {
        image
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: width, height: height)
            .foregroundColor(.white)
    }
}



struct AsyncImageMLB_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImageView(url: URL(string: "www.google.com")!, placeHolder: ImageName.Common.thumb,width: 120,height: 70)
    }
}

struct CacheAsyncImage<Content>: View where Content: View {
    
    private let url: URL
    private let scale: CGFloat
    private let transaction: Transaction
    private let content: (AsyncImagePhase) -> Content
    
    init(
        url: URL,
        scale: CGFloat = 1.0,
        transaction: Transaction = Transaction(),
        @ViewBuilder content: @escaping (AsyncImagePhase) -> Content
    ) {
        self.url = url
        self.scale = scale
        self.transaction = transaction
        self.content = content
    }
    
    var body: some View {
        
        if let cached = ImageCache[url] {
            content(.success(cached))
        } else {
            AsyncImage(
                url: url,
                scale: scale,
                transaction: transaction
            ) { phase in
                cacheAndRender(phase: phase)
            }
        }
    }
    
    func cacheAndRender(phase: AsyncImagePhase) -> some View {
        if case .success(let image) = phase {
            ImageCache[url] = image
        }
        
        return content(phase)
    }
}

private class ImageCache {
    static private var cache: [URL: Image] = [:]
    
    static subscript(url: URL) -> Image? {
        get {
            ImageCache.cache[url]
        }
        set {
            ImageCache.cache[url] = newValue
        }
    }
}
