//
//  SignUpViewModel.swift
//  POCWatchOSConnectivity
//
//  Created by Tarek Radovan on 27/09/2022.
//

import Foundation
import Combine

final class SignUpViewModel: ObservableObject, Identifiable {

  @MainActor @Published var isLoading: Bool = false

  @MainActor @Published var successfullySignedUp: Bool = false
  
  @Published var emailConfiguration = TextFieldViewConfiguration(
    title: LocalizedString.SignUpView.emailTitle,
    validations: [.email, .nonEmpty],
    errorMessage: LocalizedString.SignUpView.emailTextFieldError
  )
  
  @Published var passwordConfiguration = TextFieldViewConfiguration(
    title: LocalizedString.SignUpView.passwordTitle,
    validations: [.nonEmpty],
    isSecure: true,
    errorMessage: LocalizedString.SignUpView.passwordTextFieldError
  )
  
  @Published var passwordConfirmationConfiguration = TextFieldViewConfiguration(
    title: LocalizedString.SignUpView.confirmPasswordTitle,
    isSecure: true,
    errorMessage: LocalizedString.SignUpView.passwordConfirmationTextFieldError
  )
  
  @Published var passwordsMatch: Bool = false
  
  var isValidData: Bool {
    return [
      passwordConfiguration,
      passwordConfirmationConfiguration,
      emailConfiguration
    ].allSatisfy { $0.isValid } && passwordsMatch
  }
  
  private let authService: AuthenticationServicesProtocol
  
  init(
    authService: AuthenticationServicesProtocol = AuthenticationServices()
  ) {
    self.authService = authService
    observePasswordMatching()
  }
  
  @MainActor func signUp() async {
    isLoading = true
    let signUpResponse = await authService.signup(
      email: emailConfiguration.value,
      password: passwordConfiguration.value,
      avatarData: nil
    )
    isLoading = false
    switch signUpResponse {
    case .success:
      successfullySignedUp = true
    case .failure(let error):
      // TODO: Handle error properly
      print(error.localizedDescription)
    }
  }
  
  private func observePasswordMatching() {
    $passwordConfiguration
      .combineLatest($passwordConfirmationConfiguration)
      .map { $0.value == $1.value }
      .assign(to: &$passwordsMatch)
    
    passwordConfirmationConfiguration.validations = [
      .custom(isValid: { [weak self] _ in
        self?.passwordsMatch ?? false
      })
    ]
  }
}

private extension LocalizedString {
  enum SignUpView {
    static let emailTitle = "signup_email_title".localized
    static let passwordTitle = "signup_password_title".localized
    static let emailTextFieldError = "signup_email_textfield_error".localized
    static let confirmPasswordTitle = "signup_confirm_password_title".localized
    static let passwordTextFieldError = "signup_password_textfield_error".localized
    static let passwordConfirmationTextFieldError = "signup_password_confirmation_textfield_error".localized
  }
}
