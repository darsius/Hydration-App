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
    
    static func convert(amount: Int, from oldUnit: UnitType, to newUnit: UnitType) -> Int {
        guard oldUnit != newUnit else {
            return amount
        }
        return newUnit == .oz ? convertMlToOz(amount) : convertOzToMl(amount)
    }
    
    static func convertAll(
        dailyGoal: inout Int,
        container1: inout Int,
        container2: inout Int,
        container3: inout Int,
        from oldUnit: UnitType,
        to newUnit: UnitType
    ) {
        dailyGoal = convert(amount: dailyGoal, from: oldUnit, to: newUnit)
        container1 = convert(amount: container1, from: oldUnit, to: newUnit)
        container2 = convert(amount: container2, from: oldUnit, to: newUnit)
        container3 = convert(amount: container3, from: oldUnit, to: newUnit)
    }
}
