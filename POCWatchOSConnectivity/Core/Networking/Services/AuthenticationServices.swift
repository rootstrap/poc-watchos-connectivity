//
//  Constaints.swift
//  POCWatchOSConnectivity
//
//  Created by Karen Stoletniy on 06/9/22.
//

import Foundation
import RSSwiftNetworking

protocol AuthenticationServicesProtocol {
  func login(email: String, password: String) async -> Result<Void, Error>
  func signup(
    email: String,
    password: String,
    avatarData: Data?
  ) async -> Result<User, Error>
  func signup(
    email: String,
    password: String,
    avatarData64: Data
  ) async -> Result<User, Error>
  func logout() async -> Result<Void, Error>
  func deleteAccount() async -> Result<Void, Error>
}

internal class AuthenticationServices: AuthenticationServicesProtocol {

  enum AuthError: Error {
    case userSessionInvalid
  }

  // MARK: - Properties

  private let sessionManager: SessionManager
  private let userDataManager: UserDataManager

  private let apiClient: iOSBaseAPIClient

  init(
    sessionManager: SessionManager = .shared,
    userDataManager: UserDataManager = .shared,
    apiClient: iOSBaseAPIClient = iOSBaseAPIClient.shared
  ) {
    self.sessionManager = sessionManager
    self.userDataManager = userDataManager
    self.apiClient = apiClient
  }

  func login(email: String, password: String) async -> Result<Void, Error> {
    do {
      let response: Response<User> = try await apiClient.request(
        endpoint: AuthEndpoint.signIn(email: email, password: password)
      )
      switch response.result {
      case .success(let user):
        guard await self.saveUserSession(user, headers: response.header) else {
          return .failure(AuthError.userSessionInvalid)
        }
        return .success(())
      case .failure(let error):
        return .failure(error)
      }
    } catch let error {
      return .failure(error)
    }

  }

  /// Example Upload via Multipart requests.
  /// TODO: rails base backend not supporting multipart uploads yet
  func signup(
    email: String,
    password: String,
    avatarData: Data?
  ) async -> Result<User, Error> {

    // Mixed base64 encoded and multipart images are supported
    // in the [MultipartMedia] array
    // Example: `let image2 = Base64Media(key: "user[image]", data: picData)`
    // Then: media [image, image2]

    let endpoint = AuthEndpoint.signUp(
      email: email,
      password: password,
      passwordConfirmation: password,
      picture: nil
    )

    if let avatarData = avatarData {
      let image = MultipartMedia(key: "user[avatar]", data: avatarData)
      do {
        let response: Response<User> = try await apiClient.multipartRequest(
          endpoint: endpoint,
          paramsRootKey: "",
          media: [image]
        )
        return await getUserResult(fromResponse: response)
      } catch let error {
        return .failure(error)
      }
    } else {
      do {
        let response: Response<User> = try await apiClient.request(endpoint: endpoint)
        return await getUserResult(fromResponse: response)
      } catch let error {
        return .failure(error)
      }

    }
  }

  /// Example method that uploads base64 encoded image.
  func signup(
    email: String,
    password: String,
    avatarData64: Data
  ) async -> Result<User, Error> {
    do {
      let response: Response<User> = try await apiClient.request(
        endpoint: AuthEndpoint.signUp(
          email: email,
          password: password,
          passwordConfirmation: password,
          picture: avatarData64
        )
      )
      return await getUserResult(fromResponse: response)
    } catch let error {
      return .failure(error)
    }
  }

  @discardableResult
  func logout() async -> Result<Void, Error> {
    do {
      let response: Response<Network.EmptyResponse> = try await apiClient.request(
        endpoint: AuthEndpoint.logout
      )
      switch response.result {
      case .success:
        return .success(())
      case .failure(let error):
        return .failure(error)
      }
    } catch let error {
      return .failure(error)
    }
  }

  func deleteAccount() async -> Result<Void, Error> {
    do {
      let response: Response<Network.EmptyResponse> = try await apiClient.request(
        endpoint: AuthEndpoint.deleteAccount
      )
      switch response.result {
      case .success:
        self.userDataManager.deleteUser()
        self.sessionManager.deleteSession()
        return .success(())
      case .failure(let error):
        return .failure(error)
      }
    } catch let error {
      return .failure(error)
    }

  }

  @MainActor private func saveUserSession(
    _ user: User?,
    headers: [AnyHashable: Any]
  ) -> Bool {
    userDataManager.currentUser = user
    guard let session = Session(headers: headers) else { return false }
    sessionManager.saveUser(session: session)

    return userDataManager.currentUser != nil && sessionManager.currentSession?.isValid ?? false
  }

  @MainActor private func getUserResult(
    fromResponse response: Response<User>
  ) -> Result<User, Error> {
    switch response.result {
    case .success(let user):
      if
        let user = user,
        self.saveUserSession(user, headers: response.header)
      {
        return .success(user)
      } else {
        return .failure(AuthError.userSessionInvalid)
      }
    case .failure(let error):
      return .failure(error)
    }
  }
}
