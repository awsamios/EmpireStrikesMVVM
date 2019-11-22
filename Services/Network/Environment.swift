//
//  Environment.swift
//  EmpireStrikesMVVM
//
//  Created by Samira CHALAL on 30/10/2019.
//  Copyright © 2019 ACME. All rights reserved.
//

import Foundation

struct Environment: NetworkEnvrionmentProvider {
  var host: String
  var headers: [String: Any]
  var timeOut: TimeInterval
  var cachePolicy: String
  
  init(host: String, headers: [String : Any]=[:], timeOut: TimeInterval = 10, cachePolicy: String = "") {
    self.host = host
    self.timeOut = timeOut
    self.cachePolicy = cachePolicy
    self.headers = headers
  }
}
