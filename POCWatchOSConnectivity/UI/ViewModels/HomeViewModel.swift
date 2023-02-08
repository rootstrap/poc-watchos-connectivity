//
//  HomeViewModel.swift
//  POCWatchOSConnectivity
//
//  Created by German on 9/1/23.
//

import Foundation

internal final class HomeViewModel {
  private let sessionManager: SessionManager
  private let userManager: UserDataManager

  init(
    sessionManager: SessionManager = .shared,
    userManager: UserDataManager = .shared
  ) {
    self.sessionManager = sessionManager
    self.userManager = userManager
  }

  @MainActor func logout() async {
    userManager.deleteUser()
    sessionManager.deleteSession()
    await AuthenticationServices().logout()
  }
}
