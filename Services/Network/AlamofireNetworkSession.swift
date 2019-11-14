//
//  AlamofireNetworkSession.swift
//  EmpireStrikesMVVM
//
//  Created by Samira CHALAL on 30/10/2019.
//  Copyright © 2019 ACME. All rights reserved.
//

import Foundation
import Alamofire

class AlamofireNetworkSession: NetworkSessionProvider {
  
  var environment: NetworkEnvrionmentProvider
  
  lazy var manager: SessionManager = {
    let conf = URLSessionConfiguration.default
    conf.timeoutIntervalForRequest = environment.timeOut
    conf.timeoutIntervalForResource = environment.timeOut
    conf.httpAdditionalHeaders = environment.headers
    conf.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData //TODO manage cachePolicy
    
    return SessionManager(configuration: conf)
  }()
  
  
  required init(environment: NetworkEnvrionmentProvider) {
    self.environment = environment
  }
  
  func request(request: RequestInputProvider) throws -> NetworkRequest {
    var encoding: ParameterEncoding
    let method = HTTPMethod(rawValue: request.method.rawValue) ?? HTTPMethod.get
    
    if request.encoding == .json {
      encoding = JSONEncoding.default
    } else {
      encoding = URLEncoding.default
    }
    
    guard let url = self.prepareUrl(path: request.path) else {
      throw NetworkError.invalidRequest
    }
    
    let requestInput = manager.request(url, method: method,
                                       parameters: request.parameters, encoding: encoding)
    
    Logger.info(requestInput.description)
    return ESDataRequest(requestInput)
    
  }
  
  private func prepareUrl(path: String) -> URL? {
    let baseURL = environment.host
    let fullURL = baseURL.last == "/" ? "\(baseURL)\(path)" : "\(baseURL)/\(path)"
    return URL(string: fullURL)
  }
}

extension AlamofireNetworkSession {
  class ESDataRequest: NetworkRequest {
    
    private var request: DataRequest
    
    init(_ request: DataRequest) {
      self.request = request
    }
    
    func execute(completion: @escaping RequestCompletion) {
      request.validate().responseData { response in
        switch response.result {
        case .success(let data):
          completion(.success(data))
          
        case .failure(let error):
          completion(.failure(error))
        }
      }
    }
    
    func cancel() {
      request.cancel()
    }
  }
}
