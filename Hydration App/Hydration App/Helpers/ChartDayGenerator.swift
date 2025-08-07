//
//  ChartDayGenerator.swift
//  Hydration App
//
//  Created by Paraschiv, Darius on 05.08.2025.
//

import Foundation

struct ChartDayGenerator {
    let calendar = Calendar.current
    
    func generateRandomChartDay(_ daysAgo: Int) -> HydrationDay {
        return HydrationDay(
            dailyGoal: Int.random(in: 1600...2300),
            currentAmount: Int.random(in: 1400...2300),
            date: calendar.date(byAdding: .day, value: -daysAgo, to: Date())!.startOfDay,
            unit: "ml"
        )
    }
    
    func generateEmptyChartDay(_ daysAgo: Int) -> HydrationDay {
        return HydrationDay(
            dailyGoal: 0,
            currentAmount: 0,
            date: calendar.date(byAdding: .day, value: -daysAgo, to: Date())!.startOfDay,
            unit: "ml"
        )
    }
}
