//
//  TextFieldViewConfiguration.swift
//  POCWatchOSConnectivity
//
//  Created by Leandro Higa on 31/08/2022.
//

import Foundation

final class TextFieldViewConfiguration: ObservableObject {
  var value: String = "" {
    didSet {
      validate()
    }
  }
  
  var validations: [ValidationType]
  var errorMessage: String
  var title: String
  var isSecure = false
  
  private(set) var isValid = true
  
  var isEmpty: Bool {
    value.isEmpty
  }
  
  var shouldShowError: Bool {
    !isEmpty && !isValid
  }
  
  init(
    title: String,
    value: String = "",
    validations: [ValidationType] = [.none],
    isSecure: Bool = false,
    errorMessage: String = ""
  ) {
    self.title = title
    self.value = value
    self.validations = validations
    self.errorMessage = errorMessage
    self.isSecure = isSecure
    
    validate()
  }
  
  func validate() {
    isValid = value.validates(validations)
  }
}
