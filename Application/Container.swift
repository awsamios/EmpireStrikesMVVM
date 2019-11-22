//
//  AppContainer.swift
//  EmpireStrikesMVVM
//
//  Created by Samira CHALAL on 31/10/2019.
//  Copyright © 2019 ACME. All rights reserved.
//

import Foundation
class EmpireStrikesMVVM {
  class Container {
    struct Dependencies {
      let service: NetworkServiceProvider
    }

    let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
      self.dependencies = dependencies
    }
  }

  private init() {}
  static let `shared` = EmpireStrikesMVVM()

  lazy var defaultContainer = { () -> EmpireStrikesMVVM.Container in
    
    let environment = Environment(host: "http://www.mocky.io/v2")
    
    let session = AlamofireNetworkSession(environment: environment)
    let network = Network(session: session)
    let service = NetworkService(provider: network)
    service.dateFormatter = DateFormatter()
    service.dateFormatter?.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ" //TODO not here
    
    return Container(dependencies:
      Container.Dependencies(service: service))
  }()
}
