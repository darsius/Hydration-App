//
//  TodayProgress.swift
//  Hydration App
//
//  Created by Paraschiv, Darius on 29.07.2025.
//

import Foundation

class TodayModel: Codable {
    var dailyGoal: Int
    var currentAmount: Int

    init(dailyGoal: Int, currentAmount: Int) {
        self.dailyGoal = dailyGoal
        self.currentAmount = currentAmount
    }
}
