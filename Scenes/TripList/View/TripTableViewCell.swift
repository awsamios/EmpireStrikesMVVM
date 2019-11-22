//
//  TripTableViewCell.swift
//  EmpireStrikesMVVM
//
//  Created by Samira CHALAL on 29/10/2019.
//  Copyright © 2019 ACME. All rights reserved.
//

import UIKit

class TripTableViewCell: UITableViewCell {
  
  @IBOutlet weak var pilotImageView: UIImageView!
  @IBOutlet weak var pilotNameLabel: UILabel!
  @IBOutlet weak var pickUpNameLabel: UILabel!
  @IBOutlet weak var dropOffNameLabel: UILabel!
 // @IBOutlet weak var ratingView: RatingView!
  @IBOutlet weak var ratingViewHeightConstraint: NSLayoutConstraint!
  
  let ratingViewHeight: CGFloat = 22
  
  func configure(_ trip: TripsItemViewModelProtocol) {
    pilotImageView.image = UIImage(named: trip.pilotPhotoName)
    pilotNameLabel.text = trip.pilotName
    pickUpNameLabel.text = trip.pickUpName
    dropOffNameLabel.text = trip.dropOffName
   // updateRatingView(rating: trip.rating, isVisible: trip.isRatingVisible)
  }
  
 /* func updateRatingView(rating: Double, isVisible: Bool) {
    ratingView.setRate(rating, for: .small)
    if isVisible {
      ratingViewHeightConstraint.constant = ratingViewHeight
      ratingView.alpha = 1
    } else {
      ratingViewHeightConstraint.constant = 0
      ratingView.alpha = 0
    }
  }*/
}
