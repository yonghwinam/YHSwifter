//
//  YHHeaders.swift
//
//  Created by Yonghwi on 8/5/24
//  Copyright (c) . All rights reserved.
//

import Foundation

public struct YHHeaders: Codable {

  enum CodingKeys: String, CodingKey {
    case xAmznTraceId = "X-Amzn-Trace-Id"
    case acceptLanguage = "Accept-Language"
    case userAgent = "User-Agent"
    case accept = "Accept"
    case host = "Host"
    case acceptEncoding = "Accept-Encoding"
  }

  public var xAmznTraceId: String?
  public var acceptLanguage: String?
  public var userAgent: String?
  public var accept: String?
  public var host: String?
  public var acceptEncoding: String?



  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    xAmznTraceId = try container.decodeIfPresent(String.self, forKey: .xAmznTraceId)
    acceptLanguage = try container.decodeIfPresent(String.self, forKey: .acceptLanguage)
    userAgent = try container.decodeIfPresent(String.self, forKey: .userAgent)
    accept = try container.decodeIfPresent(String.self, forKey: .accept)
    host = try container.decodeIfPresent(String.self, forKey: .host)
    acceptEncoding = try container.decodeIfPresent(String.self, forKey: .acceptEncoding)
  }

}
