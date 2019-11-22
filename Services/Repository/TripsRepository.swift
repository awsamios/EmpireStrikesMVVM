//
//  TripsRepository.swift
//  EmpireStrikesMVVM
//
//  Created by Samira CHALAL on 30/10/2019.
//  Copyright © 2019 ACME. All rights reserved.
//

import Foundation

protocol TripsRepositoryProvider {
  init(service: NetworkServiceProvider)
  func fetchTrips(completion: @escaping TripsCompletion)
}

class TripsRepository: TripsRepositoryProvider {
  
  private var service: NetworkServiceProvider
  
  required init(service: NetworkServiceProvider) {
    self.service = service
  }
  
  func fetchTrips(completion: @escaping (Result<[Trip], Error>) -> Void) {
    let request = RequestInput(path: "5db9b01930000015685ee56a/trips", method: .get)
    self.service.execute([Trip].self, request: request, completion: completion)
  }
}
