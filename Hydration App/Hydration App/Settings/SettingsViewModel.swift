//
//  SettingsViewModel.swift
//  Hydration App
//
//  Created by Paraschiv, Darius on 08.08.2025.
//

import Foundation
import SwiftUICore


class SettingsViewModel: ObservableObject {
    private let userDefaults = UserDefaults.standard
    
    @Published var unit: UnitType {
        didSet {
            convertAll(from: oldValue, to: unit)
        }
    }
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
    
    private func convertAll(from oldUnit: UnitType, to newUnit: UnitType) {
        guard oldUnit != newUnit else { return }
        
        Converter.convertAll(
            dailyGoal: &dailyGoal,
            container1: &container1,
            container2: &container2,
            container3: &container3,
            from: oldUnit,
            to: newUnit)
        
        userDefaults.set(dailyGoal, forKey: UserDefaultsKeys.dailyGoal)
        userDefaults.set(container1, forKey: UserDefaultsKeys.container1)
        userDefaults.set(container2, forKey: UserDefaultsKeys.container2)
        userDefaults.set(container3, forKey: UserDefaultsKeys.container3)
        userDefaults.set(unit.rawValue, forKey: UserDefaultsKeys.unit)
    }
}
