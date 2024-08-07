//
//  YHCartoonizerModel.swift
//
//  Created by Yonghwi on 8/6/24
//  Copyright (c) . All rights reserved.
//

import Foundation

struct YHCartoonizerModel: Codable {

  enum CodingKeys: String, CodingKey {
    case message
    case processingTime = "processing_time"
    case fileName = "file_name"
    case artworkUrl = "artwork_url"
  }

  var message: String?
  var processingTime: String?
  var fileName: String?
  var artworkUrl: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    message = try container.decodeIfPresent(String.self, forKey: .message)
    processingTime = try container.decodeIfPresent(String.self, forKey: .processingTime)
    fileName = try container.decodeIfPresent(String.self, forKey: .fileName)
    artworkUrl = try container.decodeIfPresent(String.self, forKey: .artworkUrl)
  }

}
