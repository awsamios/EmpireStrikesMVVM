//
//  NetworkProtocols.swift
//  EmpireStrikesMVVM
//
//  Created by Samira CHALAL on 30/10/2019.
//  Copyright © 2019 ACME. All rights reserved.
//

import Foundation
typealias NetworkCompletion = (Result<Data?, NetworkError>)-> Void
// MARK: NetworkRequest
typealias RequestCompletion = (Result<Any, Error>) -> Void

enum NetworkMethod: String {
  case get     = "GET"
  case post    = "POST"
  case put     = "PUT"
  case delete  = "DELETE"
}
enum NetworkEncoding {
  case url
  case json
}

enum NetworkError: Error {
  case statusCode(Int)
  case timeOut
  case networkUnavailable
  case badRequest
  case error(Error)
  case invalidRequest
}

protocol NetworkRequest {
  func execute(completion: @escaping RequestCompletion)
  func cancel()
}

protocol RequestInputProvider {
  var path: String {get set}
  var method: NetworkMethod {get set}
  var headers: [String : Any] {get set}
  var parameters: [String : Any] {get set}
  var encoding: NetworkEncoding {get set}
}

protocol NetworkEnvrionmentProvider {
  var host: String{get set}
  var headers: [String : Any] {get set}
  var timeOut: TimeInterval {get set}
}

protocol NetworkSessionProvider {
  init(environment: NetworkEnvrionmentProvider)
  func request(request: RequestInputProvider) throws -> NetworkRequest
}

protocol NetworkProvider {
  init(session: NetworkSessionProvider)
  func execute(request: RequestInputProvider, completion: @escaping NetworkCompletion)
}
