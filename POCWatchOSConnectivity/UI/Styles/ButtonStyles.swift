//
//  ButtonStyles.swift
//  POCWatchOSConnectivity
//
//  Created by Karen Stoletniy on 17/8/22.
//

import SwiftUI

enum ButtonStyle {
  case primary
  case custom(
    textColor: Color,
    backgroundColor: Color,
    cornerRadius: CGFloat,
    padding: EdgeInsets,
    font: Font
  )
  
  var viewModifier: ButtonViewModifier {
    switch self {
    case .primary:
      return ButtonViewModifier(
        textColor: .white,
        backgroundColor: .gray,
        cornerRadius: UI.Button.cornerRadius,
        padding: UI.Button.edgeInsets,
        font: .title3
      )
    case .custom(let textColor,
                 let backgroundColor,
                 let cornerRadius,
                 let padding,
                 let font) :
      return ButtonViewModifier(
        textColor: textColor,
        backgroundColor: backgroundColor,
        cornerRadius: cornerRadius,
        padding: padding,
        font: font
      )
    }
  }
}

struct ButtonViewModifier: ViewModifier {
  let textColor: Color
  let backgroundColor: Color
  let cornerRadius: CGFloat
  let padding: EdgeInsets
  let font: Font
  
  func body(content: Content) -> some View {
    content
      .foregroundColor(textColor)
      .padding(padding)
      .background(backgroundColor)
      .cornerRadius(cornerRadius)
      .font(font)
  }
}

extension Button {
  
  func withStyle(_ style: ButtonStyle) -> some View {
    modifier(style.viewModifier)
  }
}
