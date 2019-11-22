//
//  NetworkService.swift
//  EmpireStrikesMVVM
//
//  Created by Samira CHALAL on 30/10/2019.
//  Copyright © 2019 ACME. All rights reserved.
//

import Foundation

enum ParsingError: Error {
  case empty
  case format
}

protocol NetworkServiceProvider {
  init(provider: NetworkProvider)
  
  var dateFormatter: DateFormatter? {get set}
  func execute<T: Codable>(_ responseType: T.Type, request: RequestInputProvider, completion: @escaping (Result<T, Error>) -> Void)
}

class NetworkService: NetworkServiceProvider {
  
  var dateFormatter: DateFormatter?
  
  private let network: NetworkProvider
  
  required init(provider: NetworkProvider) {
    self.network = provider
  }
  
  func execute<T: Decodable>(_ responseType: T.Type, request: RequestInputProvider, completion: @escaping (Result<T, Error>) -> Void) {
    
    network.execute(request: request) { result in
      
      switch result {
      case .success(let data):
        guard let data = data else {
          DispatchQueue.main.async { completion(.failure(ParsingError.empty)) }
          return
        }
        
        do {
          let jsonDecoder = JSONDecoder()
          if let dateFormatter = self.dateFormatter {
            jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
          }
          
          let result = try jsonDecoder.decode(responseType, from: data)
          DispatchQueue.main.async { completion(.success(result)) }
          
        } catch {
          DispatchQueue.main.async { completion(.failure(ParsingError.format)) }
        }
        
      case .failure(let error):
       DispatchQueue.main.async { completion(.failure(error)) }
      }
    }
  }
  
 
}
