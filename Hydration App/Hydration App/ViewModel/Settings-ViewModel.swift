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
    
    func convertedAmount(amount: Int, from oldUnit: String, to newUnit: String) -> Int {
        print("currUnit: \(oldUnit) si newUnit: \(newUnit)")
        guard oldUnit != newUnit else {
            return amount
        }
        
        return newUnit == "oz" ? convertMlToOz(amount) : convertOzToMl(amount)
    }

    func saveConvertedAmount(_ amount: Int, for key: String, newUnit: String) {
        UserDefaults.standard.set(amount, forKey: key)
        UserDefaults.standard.set(newUnit, forKey: "unit")
    }
    
}
