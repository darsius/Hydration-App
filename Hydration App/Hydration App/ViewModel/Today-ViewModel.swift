//
//  HydrationViewModel.swift
//  Hydration App
//
//  Created by Paraschiv, Darius on 28.07.2025.
//

import Foundation

@Observable
class TodayViewModel {
    private let userDefaults = UserDefaults.standard
    
    var dailyGoal: Int {
        didSet {
            userDefaults.set(dailyGoal, forKey: UserDefaultsKeys.dailyGoal)
        }
    }
    
    var currentAmount: Int {
        didSet {
            userDefaults.setValue(currentAmount, forKey: UserDefaultsKeys.currentAmount)
        }
    }
    
    var container1: Int {
        didSet {
            userDefaults.set(container1, forKey: UserDefaultsKeys.container1)
        }
    }
    
    var container2: Int {
        didSet {
            userDefaults.set(container2, forKey: UserDefaultsKeys.container2)
        }
    }
    
    var container3: Int {
        didSet {
            userDefaults.set(container3, forKey: UserDefaultsKeys.container3)
        }
    }
    
    var unit: String {
        didSet {
            userDefaults.set(unit, forKey: UserDefaultsKeys.unit)
        }
    }
    
    init() {
//        Self.clearUserDefaults()
        
        Self.setDefaulValues()
        
        dailyGoal = userDefaults.integer(forKey: UserDefaultsKeys.dailyGoal)
        currentAmount = userDefaults.integer(forKey: UserDefaultsKeys.currentAmount)
        container1 = userDefaults.integer(forKey: UserDefaultsKeys.container1)
        container2 = userDefaults.integer(forKey: UserDefaultsKeys.container2)
        container3 = userDefaults.integer(forKey: UserDefaultsKeys.container3)
        unit = userDefaults.string(forKey: UserDefaultsKeys.unit) ?? UserDefaultsKeys.unit
    }
    
    func convertCurrentAmount(from oldUnit: String, to newUnit: String) {
        currentAmount = Converter.convert(amount: currentAmount, for: UserDefaultsKeys.currentAmount, from: oldUnit, to: newUnit)
    }
    
    private static func setDefaulValues() {
        let defaults: [String: Any] = [
            UserDefaultsKeys.dailyGoal: Defaults.dailyGoal,
            UserDefaultsKeys.currentAmount: Defaults.currentAmount,
            UserDefaultsKeys.container1: Defaults.container1,
            UserDefaultsKeys.container2: Defaults.container2,
            UserDefaultsKeys.container3: Defaults.container3,
            UserDefaultsKeys.unit: Defaults.unit
        ]
        UserDefaults.standard.register(defaults: defaults)
    }
    
    
    func addAmount(amount: Int) {
        currentAmount += amount
    }
    
    var goalPrecentage: Double {
        guard dailyGoal > 0 else { return 0 }
        return Double(currentAmount) / Double(dailyGoal) * 100
    }
    
    static func clearUserDefaults() {
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.dailyGoal)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.currentAmount)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.container1)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.container2)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.container3)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.unit)
    }
}
