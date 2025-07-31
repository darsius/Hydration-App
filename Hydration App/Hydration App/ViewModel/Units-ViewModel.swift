//
//  Units-ViewModel.swift
//  Hydration App
//
//  Created by Paraschiv, Darius on 31.07.2025.
//

import Foundation

@Observable
class UnitsViewModel {
    var unitType: String
    private var unitConverter = 29.5735
    
    init(unitType: String) {
        self.unitType = unitType
    }
    
    private func convertMlToOz(_ value: Int) -> Int {
        Int(round(Double(value) / unitConverter))
    }
    
    private func convertOzToMl(_ value: Int) -> Int {
        Int(round(Double(value) * unitConverter))
    }
    
    func convertDailyGoal(to newUnit: String) {
        let currentUnit = UserDefaults.standard.string(forKey: "unit") ?? "ml"
        guard currentUnit != newUnit else { return }
        
        let currentGoal = UserDefaults.standard.object(forKey: "dailyGoal") as? Int ?? 2000
        print("valoarea curenta din goal este: \(currentGoal)")
        let newGoal: Int
        
        if newUnit == "oz" {
            newGoal = convertMlToOz(currentGoal)
        } else {
            newGoal = convertOzToMl(currentGoal)
        }
        
        UserDefaults.standard.set(newGoal, forKey: "dailyGoal")
        UserDefaults.standard.set(newUnit, forKey: "unit")
        
        unitType = newUnit
        print("valoarea noua din goal este: \(newGoal)")
        
        NotificationCenter.default.post(name: .dailyGoalChanged, object: nil)
    }
    
}
