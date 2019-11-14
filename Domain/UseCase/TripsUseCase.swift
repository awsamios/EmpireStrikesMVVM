//
//  TripsUseCase.swift
//  EmpireStrikesMVVM
//
//  Created by Samira CHALAL on 29/10/2019.
//  Copyright © 2019 ACME. All rights reserved.
//

import Foundation

typealias TripsCompletion = (Result<[Trip], Error>) -> Void
protocol UseCaseProtocol {}
struct TripsRequest {}

protocol TripsUseCaseProtocol: UseCaseProtocol {
  init(repository: TripsRepositoryProvider)
  func run(request: TripsRequest, completion: @escaping (Result<[Trip], Error>) -> Void)
  func fetchTrip(by identifier: Int) -> Trip?
}

class TripsUseCase: TripsUseCaseProtocol {
  private let repository: TripsRepositoryProvider
  
  private var trips: [Trip]?
  
  required init(repository: TripsRepositoryProvider) {
    self.repository = repository
  }
  
  func run(request: TripsRequest, completion: @escaping TripsCompletion) {
    self.repository.fetchTrips(completion: { result in
      
      guard let trips = try? result.get() else {
        
        completion(.failure(NetworkError.badRequest)) //TODO manage error here
        return
      }
      
      self.trips = trips
      
      completion(result)
    })
  }
  
  func fetchTrip(by identifier: Int) -> Trip? {
   return self.trips?.first(where: { return $0.identifier == identifier})
  }
  
  // http://www.mocky.io/v2/5db9b05030000075005ee56b
  
}
