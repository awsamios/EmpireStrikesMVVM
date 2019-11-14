//
//  TripsViewModel.swift
//  EmpireStrikesMVVM
//
//  Created by Samira CHALAL on 29/10/2019.
//  Copyright © 2019 ACME. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa


protocol TripsViewModelInput {
  func viewDidLoad()
  func didSelect(_ trip: TripsItemViewModelProtocol)
}

protocol TripsViewModelOutput {
  var trips: PublishSubject<[TripsItemViewModelProtocol]> {get}
  var error: PublishSubject<String> {get}
  var loading: PublishSubject<Bool> {get}
}

typealias TripsViewModelProtocol = TripsViewModelInput & TripsViewModelOutput

class TripsViewModel: TripsViewModelProtocol {
  // MARK: - Output properties
  var trips: PublishSubject<[TripsItemViewModelProtocol]> = PublishSubject()
  var error: PublishSubject<String> = PublishSubject()
  var loading: PublishSubject<Bool> = PublishSubject()
  
  private let disposable = DisposeBag()
  private let tripsUseCase: TripsUseCaseProtocol
  private let coordinator: Router
  
  init(tripsUseCase: TripsUseCaseProtocol, coordinator: Router) {
    self.tripsUseCase = tripsUseCase
    self.coordinator = coordinator
  }
  
  private func fetchTrips() {
    
    loading.onNext(true)
    self.tripsUseCase.run(request: TripsRequest()) { [weak self] result in
      
      guard let self = self else { return }
      
      self.loading.onNext(true)
      
      switch result {
      case .success(let trips):
        
        let displayedTrips = trips.sorted{ $0.pilot.name < $1.pilot.name }.compactMap { item -> TripsItemViewModel in
          
          var newItem = item
          // remove the first / to match the path of the avatar image static/{imageName}
          newItem.pilot.avatar.removeFirst(1)
          
          return TripsItemViewModel(
            identifier: newItem.identifier,
            pilotPhotoName: newItem.pilot.avatar,
            pilotName: newItem.pilot.name.uppercased(),
            pickUpName: newItem.pickUp.name,
            dropOffName: newItem.dropOff.name,
            rating: newItem.pilot.rating,
            isRatingVisible: newItem.pilot.rating != 0)
        }
        
        self.trips.onNext(displayedTrips)
        
      case .failure(let error):
        self.error.onNext(error.localizedDescription)
      }
    }
  }
}

extension TripsViewModel {
  func viewDidLoad() {
    fetchTrips()
  }
  
  func didSelect(_ trip: TripsItemViewModelProtocol) {
    
    guard let trip = self.tripsUseCase.fetchTrip(by: trip.identifier) else {return}
    
    self.coordinator.route(to: TripsRoute.details(trip))
  }
}
