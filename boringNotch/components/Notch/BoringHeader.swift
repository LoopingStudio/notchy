//
//  BoringHeader.swift
//  boringNotch
//
//  Created by Harsh Vardhan  Goswami  on 04/08/24.
//

import Defaults
import SwiftUI

struct BoringHeader: View {
  @EnvironmentObject var vm: BoringViewModel
  @EnvironmentObject var batteryModel: BatteryStatusViewModel
  @StateObject var tvm = TrayDrop.shared
  var body: some View {
    HStack(spacing: 0) {
      tabSelector
      notch
      settingsAndBattery
    }
    .foregroundColor(.gray)
    .environmentObject(vm)
  }

  @ViewBuilder
  private var tabSelector: some View {
    HStack {
      if (!tvm.isEmpty || vm.alwaysShowTabs) && Defaults[.boringShelf] {
        TabSelectionView()
      } else if vm.notchState == .open {
        EmptyView()
      }
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .opacity(vm.notchState == .closed ? 0 : 1)
    .blur(radius: vm.notchState == .closed ? 20 : 0)
    .animation(.smooth.delay(0.2), value: vm.notchState)
    .zIndex(2)
  }

  @ViewBuilder
  private var notch: some View {
    if vm.notchState == .open {
      Rectangle()
        .fill(
          NSScreen.screens
            .first(where: { $0.localizedName == vm.selectedScreen })?.safeAreaInsets.top ?? 0 > 0 ? .black : .clear
        )
        .frame(width: Sizes().size.closed.width! - 5)
        .mask {
          NotchShape()
        }
    }
  }

  @ViewBuilder
  private var settingsAndBattery: some View {
    if vm.notchState == .open {
      HStack(spacing: 4) {
        if Defaults[.settingsIconInNotch] {
          SettingsLink {
            Image(systemName: "gear")
              .foregroundColor(.white)
              .imageScale(.medium)
              .background {
                Circle()
                  .frame(width: 30, height: 30)
              }
          }
          .buttonStyle(.plain)
        }
        if Defaults[.showBattery] {
          BoringBatteryView(
            batteryPercentage: batteryModel.batteryPercentage,
            isPluggedIn: batteryModel.isPluggedIn, batteryWidth: 30,
            isInLowPowerMode: batteryModel.isInLowPowerMode
          )
        }
      }
      .font(.system(.headline, design: .rounded))
      .frame(maxWidth: .infinity, alignment: .trailing)
      .opacity(vm.notchState == .closed ? 0 : 1)
      .blur(radius: vm.notchState == .closed ? 20 : 0)
      .animation(.smooth.delay(0.2), value: vm.notchState)
      .zIndex(2)
    }
  }
}

#Preview {
  BoringHeader()
    .environmentObject(BoringViewModel())
    .environmentObject(BatteryStatusViewModel(vm: BoringViewModel()))
}
