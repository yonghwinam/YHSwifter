//
//  YHUserFetcher.swift
//
//  Created by Yonghwi on 8/6/24
//  Copyright (c) . All rights reserved.
//

import Foundation

struct YHUser: Codable {

  enum CodingKeys: String, CodingKey {
    case gender
    case refreshToken
    case image
    case username
    case lastName
    case token
    case email
    case firstName
    case id
  }

  var gender: String?
  var refreshToken: String?
  var image: String?
  var username: String?
  var lastName: String?
  var token: String?
  var email: String?
  var firstName: String?
  var id: Int?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    gender = try container.decodeIfPresent(String.self, forKey: .gender)
    refreshToken = try container.decodeIfPresent(String.self, forKey: .refreshToken)
    image = try container.decodeIfPresent(String.self, forKey: .image)
    username = try container.decodeIfPresent(String.self, forKey: .username)
    lastName = try container.decodeIfPresent(String.self, forKey: .lastName)
    token = try container.decodeIfPresent(String.self, forKey: .token)
    email = try container.decodeIfPresent(String.self, forKey: .email)
    firstName = try container.decodeIfPresent(String.self, forKey: .firstName)
    id = try container.decodeIfPresent(Int.self, forKey: .id)
  }

}
