//
//  TipDetailsViewController.swift
//  EmpireStrikesMVVM
//
//  Created by Samira CHALAL on 29/10/2019.
//  Copyright © 2019 ACME. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa



class TripDetailsViewController: BaseViewController {
  @IBOutlet weak var depaturePlanetImageView: UIImageView!
  @IBOutlet weak var arrivalPlanetImageView: UIImageView!
  @IBOutlet weak var pilotImageView: UIImageView!
  @IBOutlet weak var pilotNameLabel: UILabel!
  @IBOutlet weak var departureView: SpaceTravelDetailsView!
  @IBOutlet weak var arrivalView: SpaceTravelDetailsView!
  @IBOutlet weak var distanceView: SpaceTravelDetailsView!
  @IBOutlet weak var durationView: SpaceTravelDetailsView!
  //@IBOutlet weak var ratingView: RatingView!
  @IBOutlet weak var noRatingLabel: UIView!
  
  private(set) var viewModel: TripDetailsViewModelProtocol!
  private let disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupBindings()
  }
  
  private func setupBindings() {
    
    viewModel.tripDetailsData.asObservable()
      .subscribe(onNext: { //2
        [unowned self] data in
        
        var firstItem = data
        firstItem.pilotPhotoName.removeFirst() //TODO don"t do it here but in entity or presenter
        
        self.pilotImageView.image =  UIImage(named: firstItem.pilotPhotoName )
        
        self.pilotNameLabel.text = data.pilotName
        self.departureView.configure(data.departure)
        self.arrivalView.configure(data.arrival)
        
        
      })
      .disposed(by: disposeBag) //3
  }
}


extension TripDetailsViewController: ViewModelResolver {
  
  typealias VM = TripDetailsViewModelProtocol
  
  static func instance(with viewModel: VM) -> UIViewController? {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let controller = storyboard.instantiateViewController(withIdentifier: "TripDetailsViewController") as? TripDetailsViewController
    
    controller?.viewModel = viewModel
    return controller
  }
}

