//
//  SignUpView.swift
//  POCWatchOSConnectivity
//
//  Created by Tarek Radovan on 02/09/2022.
//

import SwiftUI

struct SignUpView: View {

  @ObservedObject var viewModel: SignUpViewModel

  init(viewModel: SignUpViewModel = SignUpViewModel()) {
    self.viewModel = viewModel
  }

  var body: some View {
    VStack {
      Text(LocalizedString.SignUpView.title)
        .withStyle(.primary)
        .frame(maxWidth: .infinity, alignment: .topLeading)
      Spacer()
      VStack(spacing: UI.StackView.spacing) {
        TextFieldView(fieldConfiguration: $viewModel.emailConfiguration)
        TextFieldView(fieldConfiguration: $viewModel.passwordConfiguration)
        TextFieldView(fieldConfiguration: $viewModel.passwordConfirmationConfiguration)
      }
      Spacer()
      Button {
        Task {
          await viewModel.signUp()
        }
      } label: {
        Text(LocalizedString.SignUpView.signUpButtonTitle)
      }
      .withStyle(.primary)
      .opacity(
        viewModel.isValidData
          ? UI.SignUp.validButtonOpacity
          : UI.SignUp.invalidButtonOpacity
      )
      .disabled(!viewModel.isValidData)
    }
    .containerStackView(alignment: .topLeading, hideNavBar: false)
    .showLoader(viewModel.isLoading)
  }
}

struct SignUpView_Previews: PreviewProvider {
  static var previews: some View {
    SignUpView()
  }
}

private extension UI {
  enum SignUp {
    static let validButtonOpacity: Double = 1
    static let invalidButtonOpacity: Double = 0.5
  }
}

private extension LocalizedString {
  enum SignUpView {
    static let title = "signup_screen_title".localized
    static let signUpButtonTitle = "signup_button".localized
  }
}
