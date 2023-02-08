//
//  SignInView.swift
//  POCWatchOSConnectivity
//
//  Created by Leandro Higa on 30/08/2022.
//

import SwiftUI

struct SignInView: View {
 
  @ObservedObject var viewModel = SignInViewModel()
  @State private var isLoading = false
  
  var body: some View {
    VStack {
      Text(LocalizedString.SignInScreen.title)
        .withStyle(.primary)
        .frame(maxWidth: .infinity, alignment: .topLeading)
      Spacer()
      VStack(spacing: UI.StackView.spacing) {
        TextFieldView(fieldConfiguration: $viewModel.emailConfiguration)
        TextFieldView(fieldConfiguration: $viewModel.passwordConfigurarion)
      }
      Spacer()
      NavigationLink(isActive: $viewModel.successfullyLoggedIn) {
        HomeView()
      } label: {
        Button {
          Task {
            await viewModel.logIn()
          }
        } label: {
          Text(LocalizedString.SignInScreen.signInButton)
        }
      }
      .withStyle(.primary)
      .opacity(
        viewModel.isValidData
          ? UI.SignIn.validButtonOpacity
          : UI.SignIn.invalidButtonOpacity
      )
      .disabled(!viewModel.isValidData)
    }
    .containerStackView(alignment: .topLeading, hideNavBar: false)
    .showLoader(viewModel.isLoading)
  }
}

struct SignInView_Previews: PreviewProvider {
  static var previews: some View {
    SignInView()
  }
}

private extension UI {
  enum SignIn {
    static let validButtonOpacity: Double = 1
    static let invalidButtonOpacity: Double = 0.5
  }
}

private extension LocalizedString {
  enum SignInScreen {
    static let title = "sign_in_screen_title".localized
    static let emailPlaceholder = "sign_in_screen_email_placeholder".localized
    static let passwordPlaceholder = "sign_in_screen_password_placeholder".localized
    static let signInButton = "sign_in_screen_button".localized.uppercased()
  }
}
