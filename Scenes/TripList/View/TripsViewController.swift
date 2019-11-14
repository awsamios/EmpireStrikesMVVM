//
//  TripsViewController.swift
//  EmpireStrikesMVVM
//
//  Created by Samira CHALAL on 29/10/2019.
//  Copyright © 2019 ACME. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class TripsViewController: BaseViewController, UITableViewDelegate {
  // MARK: - Outlets
  @IBOutlet weak var tableView: UITableView!
  
  private let cellIdentifier = "travelCellIdentifier"
  
  private(set) var viewModel: TripsViewModelProtocol!
  
  private var trips = PublishSubject<[TripsItemViewModelProtocol]>()
  
  /*{
   didSet {
   tableView.reloadData()
   }
   }*/
  
  let disposeBag = DisposeBag()
  
  
  /// MARK: - Life Cyle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configure()
    
    setupBindings()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    viewModel.viewDidLoad()
  }
  
  
  private func setupBindings() {
    // viewModel.loading.bind(to: self.rx.isAnimating).disposed(by: disposeBag)
    
    viewModel
      .trips
      .observeOn(MainScheduler.instance)
      .bind(to: trips)
      .disposed(by: disposeBag)
    
    self.trips.bind(to: tableView.rx.items(cellIdentifier: self.cellIdentifier, cellType: TripTableViewCell.self)) {  (row, trip,cell) in
      cell.configure(trip)
    }.disposed(by: disposeBag)
    
    tableView.rx.modelSelected(TripsItemViewModelProtocol.self)
      .subscribe(onNext: { [weak self] item in
        guard let self = self else { return }
        self.viewModel.didSelect(item)
      }).disposed(by: disposeBag)
    
   /* tableView.rx.willDisplayCell
      .subscribe(onNext: ({ (cell,indexPath) in
        cell.alpha = 0
        let transform = CATransform3DTranslate(CATransform3DIdentity, -250, 0, 0)
        cell.layer.transform = transform
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
          cell.alpha = 1
          cell.layer.transform = CATransform3DIdentity
        }, completion: nil)
      })).disposed(by: disposeBag)*/
    
    
  }
  
  func configure() {
    tableView.estimatedRowHeight = 88
    tableView.rowHeight = UITableView.automaticDimension
    tableView.backgroundView = UIImageView(image: UIImage(named: "background"))
    title = "Last Space Trips"
  }
  
}


extension TripsViewController: ViewModelResolver {
  
  static func instance(with viewModel: TripsViewModelProtocol) -> UIViewController? {
    
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let controller = storyboard.instantiateViewController(withIdentifier: "TripsViewController") as? TripsViewController
    
    controller?.viewModel = viewModel
    return controller
  }
}
