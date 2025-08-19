//
//  ChartDay.swift
//  Hydration App
//
//  Created by Paraschiv, Darius on 05.08.2025.
//

import Foundation
import SwiftData

@Model
class HydrationDay: Identifiable {
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
