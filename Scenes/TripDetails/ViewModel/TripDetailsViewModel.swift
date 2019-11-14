//
//  TripDetailsViewModel.swift
//  EmpireStrikesMVVM
//
//  Created by Samira CHALAL on 29/10/2019.
//  Copyright © 2019 ACME. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa


struct TripActionViewModel {
  var title: String
  var subtitle: String
  var details: String?
}

struct TripViewModel {
  var departure: TripActionViewModel
  var arrival: TripActionViewModel
  var pilotName: String
  var pilotPhotoName: String
  var hasRating: Bool
  var rating: Double
  
  init (departure: TripActionViewModel, arrival: TripActionViewModel, pilotName: String,pilotPhotoName: String, hasRating: Bool, rating: Double) {
    
    self.departure = departure
    self.arrival = arrival
    self.pilotPhotoName = pilotPhotoName
    self.pilotName = pilotName
    self.hasRating = hasRating
    self.rating = rating
  }
  
  
  init() {
    departure = TripActionViewModel.init(title: "", subtitle: "", details: "")
        arrival = TripActionViewModel.init(title: "", subtitle: "", details: "")
    
    self.pilotName = ""
    self.pilotPhotoName = ""
    self.hasRating = false
    self.rating = 0
  }
  
}

protocol TripDetailsViewModelInput {}

protocol TripDetailsViewModelOutput {
  var tripDetailsData: BehaviorRelay<TripViewModel> {get}
}

typealias TripDetailsViewModelProtocol =
  TripDetailsViewModelInput & TripDetailsViewModelOutput

class TripDetailsViewModel: TripDetailsViewModelProtocol {
  
  private let disposable = DisposeBag()

  var tripDetailsData: BehaviorRelay<TripViewModel>  = BehaviorRelay(value: TripViewModel())
  
  init(trip: Trip) {
    self.prepare(trip)
  }
  
  private func prepare(_ trip: Trip) {
    
    let departure = TripActionViewModel(
      title: "travel_details_departure_title", subtitle: trip.pickUp.name, details: trip.pickUp.date.readableDateTime)
    
    let arrival = TripActionViewModel(
      title: "travel_details_arrival_title", subtitle: trip.dropOff.name , details: trip.dropOff.date.readableDateTime)
    
    let tripViewModel = TripViewModel(
      departure: departure,
      arrival: arrival,
      pilotName: trip.pilot.name ,
      pilotPhotoName: trip.pilot.avatar,
      hasRating: trip.pilot.rating != 0,
      rating: trip.pilot.rating)
    
    self.tripDetailsData.accept(tripViewModel)
  }
}
