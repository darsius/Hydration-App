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
   
    init(container: ModelContainer?) {
        self.container = container
    }
}

extension ChartDayDataSource {
    func insert(_ entity: HydrationDay) {
        self.container?.mainContext.insert(entity)
    }
    
    func fetchChartDays() -> [HydrationDay] {
        let fetchDescriptor = FetchDescriptor<HydrationDay>(
            sortBy: [SortDescriptor(\HydrationDay.date)])
        let chartDays = try? self.container?.mainContext.fetch(fetchDescriptor)
        return chartDays ?? []
    }
    
    func deleteAllChartDays() {
        guard let context = container?.mainContext else { return }
        let fetchDescriptor = FetchDescriptor<HydrationDay>()
        
        do {
            let chartDays = try context.fetch(fetchDescriptor)
            chartDays.forEach { context.delete($0) }
            try context.save()
        } catch {
            print("Failed to delete all chart days: \(error)")
        }
    }

    
    func updateUnitForAllChartDays(to newUnit: String) {
        let fetchDescriptor = FetchDescriptor<HydrationDay>()
        do {
            if let chartDays = try container?.mainContext.fetch(fetchDescriptor) {
                for day in chartDays {
                    day.dailyGoal = Converter.convert(amount: day.dailyGoal, from: UnitType(rawValue: day.unit)!, to: UnitType(rawValue: newUnit)!)
                    day.currentAmount = Converter.convert(amount: day.currentAmount, from: UnitType(rawValue: day.unit)!, to: UnitType(rawValue: newUnit)!)
                    day.unit = newUnit
                }
            }
        } catch {
            print("Failed to update units: \(error)")
        }
    }
}
