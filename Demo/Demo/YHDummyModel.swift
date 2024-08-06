//
//  YHDummyModel.swift
//
//  Created by Yonghwi on 8/5/24
//  Copyright (c) . All rights reserved.
//

import Foundation

public struct YHDummyModel: Codable {

  enum CodingKeys: String, CodingKey {
    case args
    case headers
    case url
    case origin
  }

  public var args: YHArgs?
  public var headers: YHHeaders?
  public var url: String?
  public var origin: String?



  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    args = try container.decodeIfPresent(YHArgs.self, forKey: .args)
    headers = try container.decodeIfPresent(YHHeaders.self, forKey: .headers)
    url = try container.decodeIfPresent(String.self, forKey: .url)
    origin = try container.decodeIfPresent(String.self, forKey: .origin)
  }

}
