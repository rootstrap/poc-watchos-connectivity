//
//  Constaints.swift
//  POCWatchOSConnectivity
//
//  Created by Karen Stoletniy on 06/9/22.
//

import Combine
import SwiftUI
import UIKit

internal class SessionManager: CurrentUserSessionProvider {

  var isSessionValidPublisher: AnyPublisher<Bool, Never> {
    currentSessionPublisher.map { $0?.isValid ?? false }.eraseToAnyPublisher()
  }

  private var currentSessionPublisher: AnyPublisher<Session?, Never> {
    userDefaults.publisher(for: \.currentSession).eraseToAnyPublisher()
  }

  private var subscriptions = Set<AnyCancellable>()
  private let userDefaults: UserDefaults

  static let shared = SessionManager()

  init(userDefaults: UserDefaults = .standard) {
    self.userDefaults = userDefaults
  }

  private(set) var currentSession: Session? {
    get {
      userDefaults.currentSession
    }

    set {
      userDefaults.currentSession = newValue
    }
  }

  func deleteSession() {
    currentSession = nil
  }

  @MainActor func saveUser(session: Session) {
    userDefaults.currentSession = session
  }
}

fileprivate extension UserDefaults {

  static let SESSION_KEY = "sui_base_session_key"

  @objc dynamic var currentSession: Session? {
    get {
      if
        let data = data(forKey: Self.SESSION_KEY),
        let session = try? JSONDecoder().decode(Session.self, from: data)
      {
        return session
      }
      return nil
    }
    set {
      let session = try? JSONEncoder().encode(newValue)
      set(session, forKey: Self.SESSION_KEY)
    }
  }
}
