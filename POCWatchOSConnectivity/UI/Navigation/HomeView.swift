//
//  ContentView.swift
//  POCWatchOSConnectivity
//
//  Created by Fabrizio Piruzi on 21/07/2022.
//

import SwiftUI

struct HomeView: View {

  private var viewModel = HomeViewModel()

  var body: some View {
    VStack {
      Spacer()
      Text(
        LocalizedString.parametrizedString(
          format: LocalizedString.Common.exampleTitle,
          params: "to parametrized strings", "John Dee"
        )
      )
      Spacer()
      Button(LocalizedString.HomeView.homeButtonCallToAction) {
        Task {
          await viewModel.logout()
        }
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}

fileprivate extension LocalizedString {
  enum HomeView {
    static let homeButtonCallToAction = "home_logout_cta".localized
  }
}
