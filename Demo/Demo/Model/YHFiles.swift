//
//  YHFiles.swift
//
//  Created by Yonghwi on 8/6/24
//  Copyright (c) . All rights reserved.
//

import Foundation

struct YHFiles: Codable {

  enum CodingKeys: String, CodingKey {
    case file
  }

  var file: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    file = try container.decodeIfPresent(String.self, forKey: .file)
  }

}
