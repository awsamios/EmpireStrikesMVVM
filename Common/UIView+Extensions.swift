//
//  UIView+Extensions.swift
//  EmpireStrikesMVVM
//
//  Created by Samira CHALAL on 29/10/2019.
//  Copyright © 2019 ACME. All rights reserved.
//

import UIKit

extension UIView {
  
  func loadViewFromXib() {
    let bundle = Bundle.main
    let nibName = "\(type(of: self))"
    
    guard bundle.path(forResource: nibName, ofType: "nib") != nil else {
      return
    }
    
    let nib = UINib(nibName: nibName, bundle: bundle)
    
    let view = nib.instantiate(withOwner: self, options: nil).first as? UIView
    guard let mainView = view else {
      return
    }
    
    mainView.backgroundColor = UIColor.clear
    
    self.addSubview(mainView)
    mainView.frame = self.bounds
    mainView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
  }
}
