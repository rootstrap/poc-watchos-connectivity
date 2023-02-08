//
//  WelcomeView.swift
//  POCWatchOSConnectivity
//
//  Created by Karen Stoletniy on 17/8/22.
//

import SwiftUI

struct WelcomeScreenView: View {
  var body: some View {
    NavigationView {
      VStack {
        Text(LocalizedString.WelcomeScreen.title)
          .withStyle(.primary)
          .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        VStack(spacing: UI.StackView.spacing) {
          NavigationLink(LocalizedString.WelcomeScreen.loginButton) {
            SignInView()
          }
          .withStyle(.primary)
          NavigationLink(destination: SignUpView()) {
            Text(LocalizedString.WelcomeScreen.signupButton)
              .fontWeight(.semibold)
              .foregroundColor(.gray)
          }
        }
      }
      .containerStackView(alignment: .topLeading, hideNavBar: true)
    }
  }
}

struct WelcomeView_Previews: PreviewProvider {
  static var previews: some View {
    WelcomeScreenView()
  }
}

private extension LocalizedString {
  enum WelcomeScreen {
    static let title = "welcome_screen_title".localized
    static let loginButton = "welcome_screen_signin_button".localized
    static let facebookButton = "welcome_screen_facebook_button".localized
    static let signupButton = "welcome_screen_signup_button".localized
  }
}
