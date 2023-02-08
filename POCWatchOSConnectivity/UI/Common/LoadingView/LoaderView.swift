//
//  LoaderView.swift
//  POCWatchOSConnectivity
//
//  Created by Tarek Radovan on 25/10/2022.
//

import SwiftUI

struct LoaderView: View {
  var body: some View {
    ZStack {
      Rectangle()
        .foregroundColor(.placeholderGray)
        .opacity(UI.LoaderView.overlayOpacity)
        .luminanceToAlpha()
        .ignoresSafeArea()
      ProgressView()
        .tint(.white)
        .scaleEffect(2)
    }
  }
}

struct LoaderView_Previews: PreviewProvider {
  static var previews: some View {
    LoaderView()
  }
}

private extension UI {
  enum LoaderView {
    static let overlayOpacity = 0.4
  }
}
