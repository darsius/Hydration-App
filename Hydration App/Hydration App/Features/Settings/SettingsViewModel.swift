//
//  SettingsViewModel.swift
//  Hydration App
//
//  Created by Paraschiv, Darius on 08.08.2025.
//

import Foundation
import SwiftUICore


class SettingsViewModel: ObservableObject {
    @Published var unit: UnitType
    @Published var dailyGoal: Int
    @Published var container1: Int
    @Published var container2: Int
    @Published var container3: Int
    
    private let userDefaults = UserDefaults.standard
    
    init() {
        dailyGoal = userDefaults.integer(forKey: UserDefaultsKeys.dailyGoal)
        container1 = userDefaults.integer(forKey: UserDefaultsKeys.container1)
        container2 = userDefaults.integer(forKey: UserDefaultsKeys.container2)
        container3 = userDefaults.integer(forKey: UserDefaultsKeys.container3)
        unit = UnitType(rawValue: userDefaults.string(forKey: UserDefaultsKeys.unit) ?? "") ?? .ml
        NotificationCenter.default.addObserver(self, selector: #selector(unitChanged(_:)), name: .unitDidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateDailyGoal), name: .dailyGoalDidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateContainer1), name: .container1DidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateContainer2), name: .container2DidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateContainer3), name: .container3DidChange, object: nil)
    }
    
    @objc private func updateDailyGoal() {
        dailyGoal = UserDefaults.standard.integer(forKey: UserDefaultsKeys.dailyGoal)
    }
    @objc private func updateContainer1() {
        container1 = UserDefaults.standard.integer(forKey: UserDefaultsKeys.container1)
    }
    @objc private func updateContainer2() {
        container2 = UserDefaults.standard.integer(forKey: UserDefaultsKeys.container2)
    }
    @objc private func updateContainer3() {
        container3 = UserDefaults.standard.integer(forKey: UserDefaultsKeys.container3)
    }
    
    @objc func unitChanged(_ notification: Notification) {
        let oldUnit = unit
        guard let newUnitRaw = UserDefaults.standard.string(forKey: UserDefaultsKeys.unit),
              let newUnit = UnitType(rawValue: newUnitRaw),
              newUnit != oldUnit else {
            return
        }
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
        userDefaults.set(newUnit.rawValue, forKey: UserDefaultsKeys.unit)
        
        unit = newUnit
    }
}
