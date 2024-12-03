//
//  NotchShape.swift
//
// Created by Harsh Vardhan  Goswami  on 04/08/24.
//

import SwiftUI

struct NotchShape: Shape {

  var bottomCornerRadius: CGFloat

  var topCornerRadius: CGFloat {
    bottomCornerRadius > 15 ? bottomCornerRadius - 5 : 5
  }

  init(cornerRadius: CGFloat? = nil) {
    self.bottomCornerRadius = cornerRadius ?? 10
  }

  var animatableData: CGFloat {
    get { bottomCornerRadius }
    set { bottomCornerRadius = newValue }
  }

  func path(in rect: CGRect) -> Path {
    var path = Path()
    // Start from the top left corner
    path.move(to: CGPoint(x: rect.minX, y: rect.minY))
    // Top left inner curve
    path.addQuadCurve(
      to: CGPoint(x: rect.minX + topCornerRadius, y: topCornerRadius),
      control: CGPoint(x: rect.minX + topCornerRadius, y: rect.minY)  // Control point for inner curve
    )
    // Left vertical line
    path.addLine(to: CGPoint(x: rect.minX + topCornerRadius, y: rect.maxY - bottomCornerRadius))
    // Bottom left corner
    path.addQuadCurve(
      to: CGPoint(x: rect.minX + topCornerRadius + bottomCornerRadius, y: rect.maxY),
      control: CGPoint(x: rect.minX + topCornerRadius, y: rect.maxY)
    )
    path.addLine(to: CGPoint(x: rect.maxX - topCornerRadius - bottomCornerRadius, y: rect.maxY))
    // Bottom right corner
    path.addQuadCurve(
      to: CGPoint(x: rect.maxX - topCornerRadius, y: rect.maxY - bottomCornerRadius),
      control: CGPoint(x: rect.maxX - topCornerRadius, y: rect.maxY)
    )
    path.addLine(to: CGPoint(x: rect.maxX - topCornerRadius, y: rect.minY + bottomCornerRadius))

    // Closing the path to top right inner curve
    path.addQuadCurve(
      to: CGPoint(x: rect.maxX, y: rect.minY),
      control: CGPoint(x: rect.maxX - topCornerRadius, y: rect.minY)  // Control point for inner curve
    )
    path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
    return path
  }
}

#Preview {
  NotchShape()
    .frame(width: 200, height: 32)
    .padding(10)
}
