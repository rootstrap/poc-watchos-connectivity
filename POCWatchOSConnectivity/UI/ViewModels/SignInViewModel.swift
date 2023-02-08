//
//  SignInViewModel.swift
//  POCWatchOSConnectivity
//
//  Created by Leandro Higa on 31/08/2022.
//

import SwiftUI
import Combine

final class SignInViewModel: ObservableObject, Identifiable {

  @MainActor @Published var isLoading = false

  @MainActor @Published var successfullyLoggedIn = false
  
  @Published var emailConfiguration = TextFieldViewConfiguration(
    title: LocalizedString.SignInTextField.emailTitle,
    validations: [.email, .nonEmpty],
    errorMessage: LocalizedString.SignInTextField.emailError
  )

  @Published var passwordConfigurarion = TextFieldViewConfiguration(
    title: LocalizedString.SignInTextField.passwordTitle,
    validations: [.nonEmpty],
    isSecure: true,
    errorMessage: LocalizedString.SignInTextField.passwordError
  )
  
  var isValidData: Bool {
    return [emailConfiguration, passwordConfigurarion].allSatisfy { $0.isValid }
  }

  private let authService: AuthenticationServicesProtocol
  
  init(authService: AuthenticationServicesProtocol = AuthenticationServices()) {
    self.authService = authService
  }

  @MainActor func logIn() async {
    isLoading = true
    let loginResponse = await authService.login(
      email: emailConfiguration.value,
      password: passwordConfigurarion.value
    )
    isLoading = false
    switch loginResponse {
    case .success:
      successfullyLoggedIn = true
    case .failure(let error):
      // TODO: Handle error properly
      print(error.localizedDescription)
    }
  }
}

private extension LocalizedString {
  enum SignInTextField {
    static let emailTitle = "sign_in_email_textfield_title".localized
    static let emailError = "sign_in_email_textfield_error".localized
    static let passwordTitle = "sign_in_password_textfield_title".localized
    static let passwordError = "sign_in_password_textfield_error".localized
  }
}
