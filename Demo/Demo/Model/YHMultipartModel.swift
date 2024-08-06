//
//  YHMultipartModel.swift
//
//  Created by Yonghwi on 8/6/24
//  Copyright (c) . All rights reserved.
//

import Foundation

struct YHMultipartModel: Codable {

  enum CodingKeys: String, CodingKey {
    case files
    case form
    case args
    case origin
    case headers
    case url
    case data
  }

  var files: YHFiles?
  var form: YHForm?
  var args: YHArgs?
  var origin: String?
  var headers: YHHeaders?
  var url: String?
  var data: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    files = try container.decodeIfPresent(YHFiles.self, forKey: .files)
    form = try container.decodeIfPresent(YHForm.self, forKey: .form)
    args = try container.decodeIfPresent(YHArgs.self, forKey: .args)
    origin = try container.decodeIfPresent(String.self, forKey: .origin)
    headers = try container.decodeIfPresent(YHHeaders.self, forKey: .headers)
    url = try container.decodeIfPresent(String.self, forKey: .url)
    data = try container.decodeIfPresent(String.self, forKey: .data)
  }

}
