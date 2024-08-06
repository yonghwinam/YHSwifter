//
//  ContentView.swift
//  Demo
//
//  Created by Yonghwi on 8/2/24.
//

import SwiftUI
import YHSwifter
import Alamofire

struct Artwork: Codable {
    var commentCount: Int?
    var hasCeleb: Bool?
    var artWorkType: Int?
    var hasBadge: Bool?
    var likeCount: Int?
    var lang: String?
    var createDate: Int?
    var artWorkMovie: String?
    var artWorkTitle: String?
    var artWorkIdx: Int?
    var isActiveAdmin: Int?
    var hitCount: Int?
    var cuCount: Int?
    var cuTitle: String?
    var artWorkDesc: String?
    var isContest: Int?
    var cuNickName: String?
    var artWorkHashTag: String?
    var reserveSet: Bool?
    var artWorkOpenDate: Int?
    var isActive: Int?
    var artworkShareUrl: String?
}

struct User: Codable {
    var name: String?
    var age: Int?
}

struct ContentView: View {
    let swifter = YHSwifter()
    let manager = NetworkReachabilityManager(host: "www.apple.com")
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
