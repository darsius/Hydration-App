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
    var id: String
    var dailyGoal: Int
    var currentAmount: Int
    var date: Date
    
    init(id: String =  UUID().uuidString, dailyGoal: Int, currentAmount: Int, date: Date) {
        self.id = id
        self.dailyGoal = dailyGoal
        self.currentAmount = currentAmount
        self.date = date
    }
}

extension ChartDay {
    var isEmpty: Bool {
        dailyGoal == 0 && currentAmount == 0
    }
}

