//
//  Dictionary.swift
//  POCWatchOSConnectivity
//
//  Created by Karen Stoletniy on 6/9/22.
//

import Foundation

extension Dictionary where Key: ExpressibleByStringLiteral {
  
  mutating func lowercaseKeys() {
    for key in self.keys {
      if let loweredKey = String(describing: key).lowercased() as? Key {
        self[loweredKey] = self.removeValue(forKey: key)
      }
    }
  }
}
