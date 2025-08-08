//
//  Settings-ViewModel.swift
//  Hydration App
//
//  Created by Paraschiv, Darius on 08.08.2025.
//

import Foundation
import SwiftUICore


class SettingsViewModel: ObservableObject {
    private let userDefaults = UserDefaults.standard
    @Published var unit: UnitType
    @Published var dailyGoal: Int
    @Published var container1: Int
    @Published var container2: Int
    @Published var container3: Int
    
    init() {
        dailyGoal = userDefaults.integer(forKey: UserDefaultsKeys.dailyGoal)
        container1 = userDefaults.integer(forKey: UserDefaultsKeys.container1)
        container2 = userDefaults.integer(forKey: UserDefaultsKeys.container2)
        container3 = userDefaults.integer(forKey: UserDefaultsKeys.container3)
        unit = UnitType(rawValue: userDefaults.string(forKey: UserDefaultsKeys.unit) ?? "") ?? .ml
    }
}
