//
//  HydrationViewModel.swift
//  Hydration App
//
//  Created by Paraschiv, Darius on 28.07.2025.
//

import SwiftData

@Observable
class HydrationViewModel {
    var viewType: HydrationViewType
    var item: HydrationItem
    
    var context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
        self.viewType = .dailyGoal
        self.item = HydrationItem(dailyGoal: 1555)
    }
    
    func updateDailyGoal(_ newDailyGoal: Int) {
        item.dailyGoal = newDailyGoal
        try? context.save()
    }
}
