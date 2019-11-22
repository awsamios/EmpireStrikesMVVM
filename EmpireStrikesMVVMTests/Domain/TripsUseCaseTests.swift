//
//  TripsUseCaseTests.swift
//  EmpireStrikesMVVMTests
//
//  Created by Samira CHALAL on 15/11/2019.
//  Copyright © 2019 ACME. All rights reserved.
//

import Foundation
import XCTest

@testable import EmpireStrikesMVVM

class TripsUseCaseTests: XCTestCase {
  
  class NetworkSuccessMock: NetworkProvider {
    required init(session: NetworkSessionProvider) {
      
    }
    
    func execute(request: RequestInputProvider, completion: @escaping NetworkCompletion) {
      completion(.success(json))
      
    }
  }
  
  class NetworkFailureMock: NetworkProvider {
    required init(session: NetworkSessionProvider) {
      
    }
    
    func execute(request: RequestInputProvider, completion: @escaping NetworkCompletion) {
      completion(.failure(.invalidRequest))
    }
  }
  
  func testTripsUseCase_whenSuccessFetchRequest_thenGetTrips() {
    
    let expectation = self.expectation(description: "Trips fetched")
    
    let environment = Environment(host: "")
    
    let session = AlamofireNetworkSession(environment: environment)
    let network = NetworkSuccessMock(session: session)
    let service = NetworkService(provider: network)
    service.dateFormatter = DateFormatter()
    service.dateFormatter?.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ" //TODO not here
    
    let repository = TripsRepository(service: service)
    let sut = TripsUseCase(repository: repository)
    
    
    sut.run(request: TripsRequest(), completion: { result in
      if let _ = try? result.get() {
        expectation.fulfill()
      }
    })
    
    wait(for: [expectation], timeout: 5)
  }
  
  func testTripsUseCase_whenFailureFetchRequest_thenGetError() {
    
    let expectation = self.expectation(description: "Error occured")
    
    let environment = Environment(host: "")
    
    let session = AlamofireNetworkSession(environment: environment)
    let network = NetworkFailureMock(session: session)
    let service = NetworkService(provider: network)
    service.dateFormatter = DateFormatter()
    service.dateFormatter?.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ" //TODO not here
    
    let repository = TripsRepository(service: service)
    let sut = TripsUseCase(repository: repository)
    
    sut.run(request: TripsRequest(), completion: { result in
      if let _ = try? result.get() {
        XCTFail("Should not pass here")
      }
      else {
        expectation.fulfill()
      }
    }
    )
    
    wait(for: [expectation], timeout: 5)
  }
  
  var tripsMock: [Trip]? {
    
    do {
      guard let data = json else { return nil}
      let jsonDecoder = JSONDecoder()
      
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ" //TODO not here
      
      jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
      
      
      let result = try jsonDecoder.decode([Trip].self, from: data)
      return result
      
    } catch {
      return nil
    }
  }
  
  
  func testTripsUseCase_whenFetchTripRequest_thenSelectedTrip() {
    let expectation = self.expectation(description: "Trips fetched")
    
    let environment = Environment(host: "")
    
    let session = AlamofireNetworkSession(environment: environment)
    let network = NetworkSuccessMock(session: session)
    let service = NetworkService(provider: network)
    service.dateFormatter = DateFormatter()
    service.dateFormatter?.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ" //TODO not here
    
    let repository = TripsRepository(service: service)
    let sut = TripsUseCase(repository: repository)
    sut.trips = tripsMock
    
    let result = sut.fetchTrip(by: 1)
    
    if let trip = result {
      
      XCTAssertEqual(trip.pilot.name, "Dark Vador")
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 5)
  }
}
