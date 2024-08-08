//
//  YHAsyncImage.swift
//  YHSwifter
//
//  Created by Yonghwi on 8/7/24.
//

import SwiftUI

public struct YHAsyncImage<Content: View>: View {
    
    private var urlString: String = ""
    private var width: CGFloat = .zero
    private var height: CGFloat = .zero
    private var contentMode: ContentMode = .fill
    private var radious: CGFloat = .zero
    private var opacity: CGFloat = 1.0
    private let placeholder: Content
    
    @State private var uiImage: UIImage = UIImage()
    
    public init(_ urlString: String?,
                _ width: CGFloat = .zero,
                _ height: CGFloat = .zero,
                _ contentMode: ContentMode = .fill,
                radious: CGFloat = .zero,
                opacity: CGFloat = 1.0,
                @ViewBuilder placeholder: (() -> Content) = { EmptyView() }) {
        
        if urlString != nil { self.urlString = urlString! }
        self.radious = radious
        self.opacity = opacity
        self.width = width
        self.height = height
        self.contentMode = contentMode
        self.placeholder = placeholder()
    }
    
    public var body: some View {
        VStack(spacing: .zero) {
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: self.contentMode)
                .frame(width: self.width != .zero ? self.width : .infinity,
                       height: self.height != .zero ? self.height : .infinity)
                .background(content: {
                    self.placeholder
                })
                .clipShape(RoundedRectangle(cornerRadius: self.radious))
                .opacity(self.opacity)
        }
        .task {
            do {
                let imageData = try await YH.downloadData(urlString)
                self.uiImage = try imageData.toUIImage()
            } catch {
                YHErrorLog(error.localizedDescription)
            }
        }
    }
}
