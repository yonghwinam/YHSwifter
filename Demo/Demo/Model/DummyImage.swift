//
//  DummyImage.swift
//
//  Created by Yonghwi on 8/8/24
//  Copyright (c) . All rights reserved.
//

import Foundation

struct DummyImage: Codable, Hashable, Identifiable {
    enum CodingKeys: String, CodingKey {
        case height
        case url
        case downloadUrl = "download_url"
        case id
        case width
        case author
    }
    
    var height: CGFloat?
    var url: String?
    var downloadUrl: String?
    var id: String?
    var width: CGFloat?
    var author: String?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        height = try container.decodeIfPresent(CGFloat.self, forKey: .height)
        url = try container.decodeIfPresent(String.self, forKey: .url)
        downloadUrl = try container.decodeIfPresent(String.self, forKey: .downloadUrl)
        id = try container.decodeIfPresent(String.self, forKey: .id)
        width = try container.decodeIfPresent(CGFloat.self, forKey: .width)
        author = try container.decodeIfPresent(String.self, forKey: .author)
    }
}
