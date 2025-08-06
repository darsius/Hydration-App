//
//  ChartDayDataSource.swift
//  Hydration App
//
//  Created by Paraschiv, Darius on 05.08.2025.
//

import Foundation
import SwiftData

@MainActor
class ChartDayDataSource {
    private let container: ModelContainer?
    private let context: ModelContext?
    
    init(container: ModelContainer?, context: ModelContext?) {
        self.container = container
        self.context = context
    }
}

extension ChartDayDataSource {
    func insert(_ entity: HydrationDay) {
        self.container?.mainContext.insert(entity)
        try? self.container?.mainContext.save()
    }
    
    func fetchChartDays() -> [HydrationDay] {
        let fetchDescriptor = FetchDescriptor<HydrationDay>(
            sortBy: [SortDescriptor(\HydrationDay.date)])
        let chartDays = try? self.container?.mainContext.fetch(fetchDescriptor)
        return chartDays ?? []
    }
    
    func deleteAllChartDays() {
        let fetchDescriptor = FetchDescriptor<HydrationDay>()
        if let chartDays = try? self.container?.mainContext.fetch(fetchDescriptor) {
            chartDays.forEach { self.container?.mainContext.delete($0) }
            try? self.context?.save()
        }
    }
    
    func updateUnitForAllChartDays(to newUnit: String) {
        let fetchDescriptor = FetchDescriptor<HydrationDay>()
        do {
            if let chartDays = try context?.fetch(fetchDescriptor) {
                for day in chartDays {
                    day.dailyGoal = Converter.convertValue(amount: day.dailyGoal, from: day.unit, to: newUnit)
                    day.currentAmount = Converter.convertValue(amount: day.currentAmount, from: day.unit, to: newUnit)
                    day.unit = newUnit
                }
                try context?.save()
            }
        } catch {
            print("Failed to update units: \(error)")
        }
    }
}
