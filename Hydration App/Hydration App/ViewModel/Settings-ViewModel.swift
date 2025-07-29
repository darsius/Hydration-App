//
//  SettingsViewModel.swift
//  Hydration App
//
//  Created by Paraschiv, Darius on 29.07.2025.
//

import Foundation
import Observation

@Observable
class SettingsViewModel {
    var dailyGoal = HydrationInputViewModel(type: .dailyGoal)
    var container1 = HydrationInputViewModel(type: .container(1))
    var container2 = HydrationInputViewModel(type: .container(2))
    var container3 = HydrationInputViewModel(type: .container(3))
}
