//
//  Constaints.swift
//  POCWatchOSConnectivity
//
//  Created by Karen Stoletniy on 06/9/22.
//

import Foundation
import RSSwiftNetworking

internal enum UserEndpoint: RailsAPIEndpoint {

  case profile

  var path: String {
    "/user/profile"
  }

  var method: Network.HTTPMethod {
    .get
  }
}
