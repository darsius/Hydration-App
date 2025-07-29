//
//  HydrationItem.swift
//  Hydration App
//
//  Created by Paraschiv, Darius on 29.07.2025.
//

import SwiftData

@Model
class HydrationItem {
    var dailyGoal: Int
    
    init(dailyGoal: Int) {
        self.dailyGoal = dailyGoal
    }
}
