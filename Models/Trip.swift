//
//  Trip.swift
//  EmpireStrikesMVVM
//
//  Created by Samira CHALAL on 29/10/2019.
//  Copyright © 2019 ACME. All rights reserved.
//

import Foundation

struct Trip {
  var identifier: Int
  var pilot: Pilot
  var duration: TimeInterval
  var distance: Distance
  var pickUp: Action
  var dropOff: Action
}

extension Trip: Codable {
  enum CodingKeys: String, CodingKey {
    case identifier = "id"
    case pilot
    case duration
    case distance
    case pickUp = "pick_up"
    case dropOff = "drop_off"
  }
}

struct Pilot: Codable {
  var name: String
  var avatar: String
  var rating: Double
  
  enum CodingKeys: String, CodingKey {
    case name
    case avatar
    case rating
  }
}

struct Distance: Codable {
  var value: Int
  var unit: String
  
  enum CodingKeys: String, CodingKey {
    case value
    case unit
  }
}

struct Action: Codable {
  var name: String
  var picture: String
  var date: Date
  
  enum CodingKeys: String, CodingKey {
    case name
    case picture
    case date
  }
}


