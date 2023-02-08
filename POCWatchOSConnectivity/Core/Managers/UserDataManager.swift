//
//  Constaints.swift
//  POCWatchOSConnectivity
//
//  Created by Karen Stoletniy on 06/9/22.
//

import SwiftUI

class UserDataManager {
  
  static let shared = UserDataManager()

  private let userDefaults: UserDefaults

  init(userDefaults: UserDefaults = .standard) {
    self.userDefaults = userDefaults
  }

  var currentUser: User? {
    get {
      userDefaults.currentUser
    }
    
    set {
      userDefaults.currentUser = newValue
    }
  }

  var isUserLogged: Bool {
      currentUser != nil
  }
  
  func deleteUser() {
    userDefaults.currentUser = nil
  }
}

fileprivate extension UserDefaults {

  static let USER_KEY = "sui_base_user_key"

  var currentUser: User? {
    get {
      if
        let data = data(forKey: Self.USER_KEY),
        let user = try? JSONDecoder().decode(User.self, from: data)
      {
        return user
      }
      return nil
    }

    set {
      let user = try? JSONEncoder().encode(newValue)
      set(user, forKey: Self.USER_KEY)
    }
  }
}
