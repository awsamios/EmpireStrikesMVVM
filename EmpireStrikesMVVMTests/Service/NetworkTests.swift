//
//  NetworkTests.swift
//  EmpireStrikesMVVMTests
//
//  Created by Samira CHALAL on 30/10/2019.
//  Copyright © 2019 ACME. All rights reserved.
//


import XCTest
@testable import EmpireStrikesMVVM

class NetworkTests: XCTestCase {
  
  class MockSession: NetworkSessionProvider {

    private var environment: NetworkEnvrionmentProvider
    private var exepectedData: Data?
    
    required init(environment: NetworkEnvrionmentProvider) {
      self.environment = environment
    }
    
    required init(environment: NetworkEnvrionmentProvider, expetedData: Data?) {
      self.environment = environment
      self.exepectedData = expetedData
    }
    
    func request(request: RequestInputProvider) throws -> NetworkRequest {
     return NetworkRequestMock(expectedData: exepectedData)
    }
  }
  
  class NetworkRequestMock: NetworkRequest {
    var data: Data?

    init(expectedData: Data?) {
      data = expectedData
    }

    func execute(completion: @escaping RequestCompletion) {
      guard let d = data else {
        completion(.failure(NSError(domain: "", code: NSURLErrorTimedOut)))
        return
      }
      completion(.success(d))
    }

    func cancel() {}
  }
  
  struct MockEnvironment: NetworkEnvrionmentProvider {
    
    var host: String = "http://www.mocky.io/v2/" // 5db959773000005a005ee202
    var headers: [String: Any] = [:]
    var timeOut: TimeInterval = 10
    var cachePolicy: String = ""
    
  }
  
  struct MockRequestInput: RequestInputProvider {
    var path: String = "/who"
    var method: NetworkMethod = .get
    var parameters: [String : Any] = [:]
    var headers: [String : Any] = [:]
    var encoding = NetworkEncoding.json
  }
  
  func testWithExpectedResponse() {
    
    let expectedData = "{\"who\": \"Samira\"}".data(using: .utf8)
    
    let network = Network(session: MockSession(environment: MockEnvironment(), expetedData: expectedData))
    
    let expectation = self.expectation(description: "Should return correct data")
    
    network.execute(request: MockRequestInput(), completion: { result in
      guard let resultData = try? result.get() else {
        XCTFail("Should return proper response")
        return
      }
      
      XCTAssertEqual(resultData, expectedData)
      expectation.fulfill()
    })
    
    wait(for: [expectation], timeout: 0.1)
    
  }
}
