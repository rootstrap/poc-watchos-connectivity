//
//  Constaints.swift
//  POCWatchOSConnectivity
//
//  Created by Karen Stoletniy on 06/9/22.
//

import Foundation
import RSSwiftNetworking

internal class UserServices {

  private let apiClient: iOSBaseAPIClient
  private let userDataManager: UserDataManager

  init(
    userDataManager: UserDataManager = .shared,
    apiClient: iOSBaseAPIClient = iOSBaseAPIClient.shared
  ) {
    self.userDataManager = userDataManager
    self.apiClient = apiClient
  }

  func getMyProfile() async throws -> Result<User, Error>  {
    let response: Response<User> = try await apiClient.request(
      endpoint: UserEndpoint.profile
    )
    switch response.result {
    case .success(let user):
      guard let user = user else {
        return .failure(AppError.noUserFoundError)
      }
      
      self.userDataManager.currentUser = user
      return .success(user)
    case .failure(let error):
      return .failure(error)
    }
  }
}
