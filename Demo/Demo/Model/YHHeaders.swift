//
//  YHHeaders.swift
//
//  Created by Yonghwi on 8/6/24
//  Copyright (c) . All rights reserved.
//

import Foundation

struct YHHeaders: Codable {

  enum CodingKeys: String, CodingKey {
    case cacheControl = "Cache-Control"
    case xAmznTraceId = "X-Amzn-Trace-Id"
    case acceptEncoding = "Accept-Encoding"
    case contentLength = "Content-Length"
    case host = "Host"
    case contentType = "Content-Type"
    case userAgent = "User-Agent"
    case accept = "Accept"
    case postmanToken = "Postman-Token"
  }

  var cacheControl: String?
  var xAmznTraceId: String?
  var acceptEncoding: String?
  var contentLength: String?
  var host: String?
  var contentType: String?
  var userAgent: String?
  var accept: String?
  var postmanToken: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    cacheControl = try container.decodeIfPresent(String.self, forKey: .cacheControl)
    xAmznTraceId = try container.decodeIfPresent(String.self, forKey: .xAmznTraceId)
    acceptEncoding = try container.decodeIfPresent(String.self, forKey: .acceptEncoding)
    contentLength = try container.decodeIfPresent(String.self, forKey: .contentLength)
    host = try container.decodeIfPresent(String.self, forKey: .host)
    contentType = try container.decodeIfPresent(String.self, forKey: .contentType)
    userAgent = try container.decodeIfPresent(String.self, forKey: .userAgent)
    accept = try container.decodeIfPresent(String.self, forKey: .accept)
    postmanToken = try container.decodeIfPresent(String.self, forKey: .postmanToken)
  }

}
