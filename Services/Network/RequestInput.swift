//
//  RequestInput.swift
//  EmpireStrikesMVVM
//
//  Created by Samira CHALAL on 30/10/2019.
//  Copyright © 2019 ACME. All rights reserved.
//

import Foundation

class RequestInput: RequestInputProvider {
  var path: String
  var method: NetworkMethod
  var parameters: [String : Any]
  var headers: [String : Any]
  var encoding: NetworkEncoding
  
  init(path: String, method: NetworkMethod, headers: [String : Any]=[:], parameters:[String : Any]=[:], encoding: NetworkEncoding = .url) {
    
    self.path = path
    self.method = method
    self.parameters = parameters
    self.encoding = encoding
    self.headers = headers
  }
}
