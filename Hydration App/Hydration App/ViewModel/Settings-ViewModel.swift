//
//  Settings-ViewModel.swift
//  Hydration App
//
//  Created by Paraschiv, Darius on 01.08.2025.
//

import Foundation

@Observable
class SettingsViewModel {
    private var unitConverter = 29.5735
    
    private func convertMlToOz(_ value: Int) -> Int {
        Int(round(Double(value) / unitConverter))
    }
    
    private func convertOzToMl(_ value: Int) -> Int {
        Int(round(Double(value) * unitConverter))
    }
    
    func convertAll(
        dailyGoal: inout Int,
        currentAmount: inout Int,
        container1: inout Int,
        container2: inout Int,
        container3: inout Int,
        from oldUnit: String,
        to newUnit: String
    ) {
        dailyGoal = convert(amount: dailyGoal, for: UserDefaultsKeys.dailyGoal, from: oldUnit, to: newUnit)
        currentAmount = convert(amount: currentAmount, for: UserDefaultsKeys.currentAmount, from: oldUnit, to: newUnit)
        container1 = convert(amount: container1, for: UserDefaultsKeys.container1, from: oldUnit, to: newUnit)
        container2 = convert(amount: container2, for: UserDefaultsKeys.container2, from: oldUnit, to: newUnit)
        container3 = convert(amount: container3, for: UserDefaultsKeys.container3, from: oldUnit, to: newUnit)

        UserDefaults.standard.set(newUnit, forKey: UserDefaultsKeys.unit)
    }
    
    private func convert(amount: Int, for key: String, from oldUnit: String, to newUnit: String) -> Int {
        guard oldUnit != newUnit else {
            return amount
        }
        let convertedAmount = newUnit == "oz" ? convertMlToOz(amount) : convertOzToMl(amount)
        
        UserDefaults.standard.set(convertedAmount, forKey: key)
        return convertedAmount
    }
    
}
