//
//  LoaderPresenter.swift
//  POCWatchOSConnectivity
//
//  Created by Tarek Radovan on 28/10/2022.
//

import SwiftUI

struct LoaderPresenterModifier: ViewModifier {
  
  let isLoading: Bool
  
  func body(content: Content) -> some View {
    if isLoading {
      content
        .overlay {
          LoaderView()
        }
    } else {
      content
    }
  }
}

struct LoaderPresenterModifier_Previews: PreviewProvider {
  static var previews: some View {
    Text("Hello, world!")
      .modifier(LoaderPresenterModifier(isLoading: true))
  }
}

extension View {
  func showLoader(_ isLoading: Bool) -> some View {
    modifier(LoaderPresenterModifier(isLoading: isLoading))
  }
}
