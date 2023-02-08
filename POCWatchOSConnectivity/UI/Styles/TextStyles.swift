//
//  LabelStyles.swift
//  POCWatchOSConnectivity
//
//  Created by Karen Stoletniy on 17/8/22.
//

import SwiftUI

enum TextStyle {
  case primary
  case custom(textColor: Color, font: Font)
  
  var viewModifier: TextViewModifier {
    switch self {
    case .primary:
      return TextViewModifier(font: .largeTitle, textColor: .gray)
    case .custom(let textColor, let font) :
      return TextViewModifier(font: font, textColor: textColor)
    }
  }
}

struct TextViewModifier: ViewModifier {
  let font: Font
  let textColor: Color
  
  func body(content: Content) -> some View {
    content
      .font(font)
      .foregroundColor(textColor)
  }
}

extension Text {
  func withStyle(_ style: TextStyle) -> some View {
    modifier(style.viewModifier)
  }
}
