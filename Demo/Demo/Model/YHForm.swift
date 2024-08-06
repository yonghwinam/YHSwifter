//
//  YHForm.swift
//
//  Created by Yonghwi on 8/6/24
//  Copyright (c) . All rights reserved.
//

import Foundation

struct YHForm: Codable {

  enum CodingKeys: String, CodingKey {
    case filename
  }

  var filename: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    filename = try container.decodeIfPresent(String.self, forKey: .filename)
  }

}
