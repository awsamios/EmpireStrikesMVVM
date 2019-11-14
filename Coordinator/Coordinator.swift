//
//  TripsFactory.swift
//  EmpireStrikesMVVM
//
//  Created by Samira CHALAL on 29/10/2019.
//  Copyright © 2019 ACME. All rights reserved.
//

import UIKit
protocol RoutableScene {}
enum TripsRoute: RoutableScene {
  case list
  case details(Trip) //TODO pass data
}

protocol Router {
  var mainController: UIViewController? { get }
  func route(to route: RoutableScene)
}

protocol CoordinatorProtocol {
  func makeTripsViewController() -> UIViewController?
  func makeTripDetailsViewController(_ trip: Trip) -> UIViewController?
}

class TripsCoordinator: Router {
  var mainController: UIViewController?
  func route(to route: RoutableScene) {
    guard let route = route as? TripsRoute else { return }
    switch route {
      
    case .list:
      guard let viewController = makeTripsViewController() else {return}
      
      mainController = UINavigationController(rootViewController: viewController)
      
    case .details(let trip):
      
      guard let viewController = makeTripDetailsViewController(trip) else {return}
      
      (mainController as? UINavigationController)?.pushViewController(viewController, animated: true)
      
      break
    }
  }
}

extension TripsCoordinator: CoordinatorProtocol {
  func makeTripsViewController() -> UIViewController? {
    
    let respository = TripsRepository(service:     EmpireStrikesMVVM.shared.defaultContainer.dependencies.service)
    
    return TripsViewController.instance(with: TripsViewModel(tripsUseCase: TripsUseCase(repository: respository), coordinator: self))
  }
  
  func makeTripDetailsViewController(_ trip: Trip) -> UIViewController? {
    
    let viewModel = TripDetailsViewModel(trip: trip)
    return TripDetailsViewController.instance(with: viewModel)
  }
  
}


