//
//  DetailAsyncImage.swift
//  Demo
//
//  Created by Yonghwi on 8/8/24.
//

import SwiftUI
import YHSwifter

struct DetailAsyncImage: View {
    var urlString: String
    
    var body: some View {
        YHAsyncImage(urlString, 300, 300, .fit) {
            Color.yellow
        }
    }
}

#Preview {
    
    DetailAsyncImage(urlString: "https://picsum.photos/id/1/500/333")
}
