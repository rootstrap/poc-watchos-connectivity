//
//  NavigationLinkStyle.swift
//  POCWatchOSConnectivity
//
//  Created by Karen Stoletniy on 17/8/22.
//

import SwiftUI

extension NavigationLink {
  
  func withStyle(_ style: ButtonStyle) -> some View {
    modifier(style.viewModifier)
  }
}
