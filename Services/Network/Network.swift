//
//  Network.swift
//  EmpireStrikesMVVM
//
//  Created by Samira CHALAL on 30/10/2019.
//  Copyright © 2019 ACME. All rights reserved.
//

import Foundation


class Network: NetworkProvider {
  
  private var session: NetworkSessionProvider
  
  required init(session: NetworkSessionProvider) {
    self.session = session
  }
  
  func execute(request: RequestInputProvider, completion: @escaping NetworkCompletion) {
    
    do {
      let request = try self.session.request(request: request)
      
      request.execute { result in
        
        switch result {
        case .success(let response):
          completion(.success(response as? Data))
          
        case .failure(let requestError):
          
          Logger.error("Network Error: \(requestError.localizedDescription)")
          
          let error: NetworkError
          let errorCode = requestError._code
          
          switch errorCode {
          case NSURLErrorNotConnectedToInternet:
            error = .networkUnavailable
            
          case NSURLErrorTimedOut:
            error = .timeOut
            
          case 300...500:
            error = .statusCode(errorCode)
            
          default:
            error = .error(requestError)
          }
          
          completion(.failure(error))
        }
      }
    }
    catch (let error as NetworkError) {
      completion(.failure(error))
    }
    catch (let error) {
      completion(.failure(.error(error)))
    }
  }
}
