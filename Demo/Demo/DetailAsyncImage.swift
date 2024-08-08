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
    
    @StateObject private var dummyFetcher = DummyFetcher()
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(dummyFetcher.images) { post in
                    YHAsyncImage("https://picsum.photos/id/\(post.id ?? "1")/640/480")
                }
            }
        }
        .task {
            await dummyFetcher.fetchImages()
        }
        
    }
}

#Preview {
    
    DetailAsyncImage(urlString: "https://picsum.photos/id/1/500/333")
}
