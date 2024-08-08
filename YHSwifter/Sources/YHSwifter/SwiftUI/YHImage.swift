//
//  SwiftUIView.swift
//  YHSwifter
//
//  Created by Yonghwi on 8/8/24.
//

import SwiftUI

public struct YHImage<Content: View>: View {
    private var name: String
    private var width: CGFloat = .zero
    private var height: CGFloat = .zero
    private var contentMode: ContentMode = .fill
    private var radious: CGFloat = .zero
    private var opacity: CGFloat = 1.0
    private let placeholder: Content
    
    public init(_ name: String,
                _ width: CGFloat = .zero,
                _ height: CGFloat = .zero,
                _ contentMode: ContentMode = .fill,
                radious: CGFloat = .zero,
                opacity: CGFloat = 1.0, @ViewBuilder placeholder: () -> Content = {EmptyView()}) {
        
        self.name = name
        self.radious = radious
        self.opacity = opacity
        self.width = width
        self.height = height
        self.contentMode = contentMode
        self.placeholder = placeholder()
    }
    
    public var body: some View {
        VStack(spacing: .zero) {
            Image(self.name)
                .resizable()
                .aspectRatio(contentMode: self.contentMode)
                .frame(width: self.width != .zero ? self.width : .infinity,
                       height: self.height != .zero ? self.height : .infinity)
                .opacity(self.opacity)
                .background(content: {
                    self.placeholder
                })
                .clipShape(RoundedRectangle(cornerRadius: self.radious))
        }
    }
}
