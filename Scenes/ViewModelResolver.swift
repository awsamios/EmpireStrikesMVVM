//
//  ViewModelable.swift
//  EmpireStrikesMVVM
//
//  Created by Samira CHALAL on 29/10/2019.
//  Copyright © 2019 ACME. All rights reserved.
//

import UIKit

protocol ViewModelResolver: UIViewController {
  associatedtype VM
  var viewModel: VM! { get }
  static func instance(with viewModel: VM) -> UIViewController?
}
