//
//  ChartDay.swift
//  Hydration App
//
//  Created by Paraschiv, Darius on 12.08.2025.
//

import Foundation

struct ChartDay: Identifiable {
    var dailyGoal: Int
    var currentAmount: Int
    var date: Date
    var unit: String
    
    var id: Int {
        var hasher = Hasher()
        hasher.combine(unit)
        hasher.combine(date)
        return hasher.finalize()
    }
}

extension ChartDay {
    var goalPrecentage: Int {
        guard dailyGoal > 0 else { return 0 }
        return min(100, Int(Double(currentAmount) / Double(dailyGoal) * 100))
    }
}
