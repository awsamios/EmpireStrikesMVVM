//
//  Date+String.swift
//  EmpireStrikesMVVM
//
//  Created by Samira CHALAL on 04/11/2019.
//  Copyright © 2019 ACME. All rights reserved.
//

import Foundation
extension Date {
  /// Convert the current date to a readable string using the given format.
  ///
  /// - parameter format: The format of the output string.
  /// - returns: A readable string that represent the date.
  func toString(format: String) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    formatter.dateFormat = format
    
    return formatter.string(from: self)
  }
  
  /// Get the time date as a readable string
  /// Output format: 7:35 PM
  var readableDateTime: String {
    return self.toString(format: "h:mm a")
  }
}
