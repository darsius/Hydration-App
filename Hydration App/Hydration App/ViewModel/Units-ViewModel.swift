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
    
    func convertAmount(for key: String, to newUnit: String, notify notification: Notification.Name? = nil) {
        let currentUnit = UserDefaults.standard.string(forKey: "unit") ?? "ml"
        let currentValue = UserDefaults.standard.object(forKey: key) as? Int ?? 0
        
        let newValue: Int
        
        newValue = newUnit == "oz" ? convertMlToOz(currentValue) : convertOzToMl(currentValue)
 
        guard currentUnit != newUnit || currentValue != newValue else { return }
        
        UserDefaults.standard.set(newValue, forKey: key)
        UserDefaults.standard.set(newUnit, forKey: "unit")
        
        unitType = newUnit
        print("valoarea noua este: \(newValue)")
        
        if let notification {
            NotificationCenter.default.post(name: notification, object: nil)
        }
    }
    
}
