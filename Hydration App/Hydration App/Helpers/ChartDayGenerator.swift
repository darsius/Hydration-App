//
//  ChartDayGenerator.swift
//  Hydration App
//
//  Created by Paraschiv, Darius on 05.08.2025.
//

import Foundation

struct ChartDayGenerator {
    private let calendar = Calendar.current
    private(set) var currentUnit: String = UserDefaults.standard.string(forKey: UserDefaultsKeys.unit) ?? "ml"
    
    func generateRandomHydrationDay(_ daysAgo: Int) -> HydrationDay {
        return HydrationDay(
            dailyGoal: currentUnit == "ml" ? Int.random(in: 1600...2300) : Int.random(in: 54...78),
            currentAmount: currentUnit == "ml" ? Int.random(in: 1600...2300) : Int.random(in: 54...78),
            date: getDate(daysAgo: daysAgo).startOfDay,
            unit: currentUnit
        )
    }
    
    func generateEmptyChartDay(_ daysAgo: Int) -> ChartDay {
        return ChartDay (
            dailyGoal: 0,
            currentAmount: 0,
            date: getDate(daysAgo: daysAgo).startOfDay,
            unit: currentUnit
        )
    }
}

private extension ChartDayGenerator {
    func getDate(daysAgo: Int) -> Date {
        guard let date = calendar.date(byAdding: .day, value: -daysAgo, to: Date()) else {
            fatalError("can't get the date")
        }
        
        return date
    }
}
