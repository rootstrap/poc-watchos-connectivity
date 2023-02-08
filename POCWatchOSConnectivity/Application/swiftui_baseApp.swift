//
//  swiftui_baseApp.swift
//  POCWatchOSConnectivity
//
//  Created by Fabrizio Piruzi on 21/07/2022.
//

import SwiftUI

@main
struct swiftui_baseApp: App {
    
  //State management example

  @State var isAuthenticated = false

  var body: some Scene {
    WindowGroup {
      Group {
        CounterView()
      }
      .onReceive(SessionManager.shared.isSessionValidPublisher, perform: { value in
        isAuthenticated = value
      })
    }
  }
}
