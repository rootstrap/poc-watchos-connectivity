//
//  Constants.swift
//  POCWatchOSConnectivity
//
//  Created by Karen Stoletniy on 6/9/22.
//

import Foundation

enum AppError: Error {
  case multipartImageError
  case noUserFoundError
  
  var localizedDescription: String {
    switch self {
    case .multipartImageError:
      return "Multipart image data could not be constructed"
    case .noUserFoundError:
      return "Could not parse a valid user"
    }
  }
}
