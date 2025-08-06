//
//  Converter.swift
//  Hydration App
//
//  Created by Paraschiv, Darius on 03.08.2025.
//

import Foundation

struct Converter {
    private static let unitConverter = 29.5735
    
    private static func convertMlToOz(_ value: Int) -> Int {
        Int(round(Double(value) / unitConverter))
    }
    
    private static func convertOzToMl(_ value: Int) -> Int {
        Int(round(Double(value) * unitConverter))
    }
    
    static func convert(amount: Int, for key: String, from oldUnit: UnitType, to newUnit: UnitType) -> Int {
        guard oldUnit != newUnit else {
            return amount
        }
        let convertedAmount = newUnit == UnitType.oz ? convertMlToOz(amount) : convertOzToMl(amount)
        
        UserDefaults.standard.set(convertedAmount, forKey: key)
        return convertedAmount
    }
    
    static func convertValue(amount: Int, from oldUnit: String, to newUnit: String) -> Int {
        guard oldUnit != newUnit else {
            return amount
        }
        let convertedAmount = newUnit == "oz" ? convertMlToOz(amount) : convertOzToMl(amount)
        return convertedAmount
    }
    
    static func convertAll(
        dailyGoal: inout Int,
        container1: inout Int,
        container2: inout Int,
        container3: inout Int,
        from oldUnit: UnitType,
        to newUnit: UnitType
    ) {
        dailyGoal = convert(amount: dailyGoal, for: UserDefaultsKeys.dailyGoal, from: oldUnit, to: newUnit)
        container1 = convert(amount: container1, for: UserDefaultsKeys.container1, from: oldUnit, to: newUnit)
        container2 = convert(amount: container2, for: UserDefaultsKeys.container2, from: oldUnit, to: newUnit)
        container3 = convert(amount: container3, for: UserDefaultsKeys.container3, from: oldUnit, to: newUnit)

        UserDefaults.standard.set(newUnit.rawValue, forKey: UserDefaultsKeys.unit)
    }
}
