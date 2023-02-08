//
//  StackViewStyle.swift
//  POCWatchOSConnectivity
//
//  Created by Karen Stoletniy on 17/8/22.
//

import SwiftUI

struct ContainerStackViewModifier: ViewModifier {
  let alignment: Alignment
  let hidesNavigationBar: Bool
  
  func body(content: Content) -> some View {
    content
      .frame(
        minWidth: 0,
        maxWidth: .infinity,
        minHeight: 0,
        maxHeight: .infinity,
        alignment: alignment
      )
      .padding()
      .navigationBarHidden(hidesNavigationBar)
  }
}

extension VStack {
  func containerStackView(alignment: Alignment, hideNavBar: Bool) -> some View {
    modifier(ContainerStackViewModifier(alignment: alignment, hidesNavigationBar: hideNavBar))
  }
}
