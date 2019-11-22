//
//  TripsItemViewModel.swift
//  EmpireStrikesMVVM
//
//  Created by Samira CHALAL on 29/10/2019.
//  Copyright © 2019 ACME. All rights reserved.
//

import Foundation

protocol TripsItemViewModelProtocol {
  var identifier: Int {get}
  var pilotPhotoName: String {get}
  var pilotName: String {get}
  var pickUpName: String {get}
  var dropOffName: String {get}
  var rating: Double {get}
  var isRatingVisible: Bool {get}
}

struct TripsItemViewModel: TripsItemViewModelProtocol {
  var identifier: Int
  var pilotPhotoName: String
  var pilotName: String
  var pickUpName: String
  var dropOffName: String
  var rating: Double
  var isRatingVisible: Bool
}
