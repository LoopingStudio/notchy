//
//  HoverButton.swift
//  boringNotch
//
//  Created by Kraigo on 04.09.2024.
//

import SwiftUI

struct HoverButton: View {
  var icon: String
  var iconColor: Color = .white
  var action: () -> Void
  var contentTransition: ContentTransition = .symbolEffect
  
  @State private var isHovering = false
  
  var body: some View {
    Button(action: action) {
      Image(systemName: icon)
        .foregroundColor(iconColor)
        .contentTransition(contentTransition)
        .imageScale(.medium)
        .frame(width: 30, height: 30)
        .background {
          Circle()
            .fill(isHovering ? Color.gray.opacity(0.3) : .clear)
        }
        .contentShape(Rectangle())
    }
    .buttonStyle(.plain)
    .onHover { isHovering = $0 }
    .animation(.smooth(duration: 0.3), value: isHovering)
  }
}
