//
//  ChartDay.swift
//  Hydration App
//
//  Created by Paraschiv, Darius on 05.08.2025.
//

import Foundation
import SwiftData

@Model
class ChartDay: Identifiable {
    var dailyGoal: Int
    var currentAmount: Int
    var date: Date
    var unit: String
    
    init(dailyGoal: Int, currentAmount: Int, date: Date, unit: String) {
        self.dailyGoal = dailyGoal
        self.currentAmount = currentAmount
        self.date = date
        self.unit = unit
    }
}

extension ChartDay {
    var goalPrecentage: Int {
        guard dailyGoal > 0 else { return 0 }
        return min(100, Int(Double(currentAmount) / Double(dailyGoal) * 100))
    }
    
    var isEmpty: Bool {
        dailyGoal == 0 && currentAmount == 0
    }
}

