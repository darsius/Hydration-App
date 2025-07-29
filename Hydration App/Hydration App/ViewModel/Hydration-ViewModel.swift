//
//  HydrationViewModel.swift
//  Hydration App
//
//  Created by Paraschiv, Darius on 28.07.2025.
//

import Foundation

@Observable
class HydrationViewModel {
    var type: HydrationViewType
    var dailyGoal: Int
    
    init(type: HydrationViewType) {
        self.type = type
        self.dailyGoal = type.defaultDailyGoal
    }
}
