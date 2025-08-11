//
//  History-ViewModel.swift
//  Hydration App
//
//  Created by Paraschiv, Darius on 05.08.2025.
//

import Foundation

struct ChartDay: Identifiable {
    var dailyGoal: Int
    var currentAmount: Int
    var date: Date
    var unit: String
    
    var id: Int {
        var hasher = Hasher()
        hasher.combine(unit)
        hasher.combine(date)
        return hasher.finalize()
    }
}

extension ChartDay {
    var goalPrecentage: Int {
        guard dailyGoal > 0 else { return 0 }
        return min(100, Int(Double(currentAmount) / Double(dailyGoal) * 100))
    }
}

@MainActor
class HistoryViewModel: ObservableObject {
    private let dataSource: ChartDayDataSource
    private let chartDayGenerator: ChartDayGenerator
    
    @Published var chartDays: [ChartDay] = []
    
    
    private var hasGeneratedInitialDays = false
    var hasOnlyEmptyDays = true
    
    var maxDailyGoal: Int {
        chartDays.map { $0.dailyGoal }.max() ?? 2000
    }
    
    init(dataSource: ChartDayDataSource, chartDayGenerator: ChartDayGenerator) {
        self.dataSource = dataSource
        self.chartDayGenerator = chartDayGenerator
        
//        deleteAllChartDays()
        generateInitialChartDays(count: 2)
        
        NotificationCenter.default.addObserver(self, selector: #selector(unitChanged(_:)), name: .unitDidChange, object: nil)
    }
    
    @objc func unitChanged(_ notification: Notification?) {
        let newUnit = UserDefaults.standard.string(forKey: UserDefaultsKeys.unit) ?? "ml"
        print("noul unit: \(newUnit)") //
        Task { @MainActor in
            dataSource.updateUnitForAllChartDays(to: newUnit)
            let hydrationDays = dataSource.fetchChartDays()
            chartDays = mapHydrationDaysToChartDays(hydrationDays)
        }
    }
    
    private func generateInitialChartDays(count: Int = 30) {
        var hydrationDays = dataSource.fetchChartDays()
        hydrationDays.forEach { day in
            print(day.dailyGoal, day.currentAmount, day.date)
        }
        if hydrationDays.isEmpty {
            for i in 1...count {
                let day = chartDayGenerator.generateRandomHydrationDay(i)
                dataSource.insert(day)
                hydrationDays.append(day)
            }
        }
        
        chartDays = mapHydrationDaysToChartDays(hydrationDays)
    }
    
    private func mapHydrationDaysToChartDays(_ days: [HydrationDay]) -> [ChartDay] {
        let emptyDays = generateEmptyChartDays()
        return emptyDays.map { emptyDay in
            if let existingDay = days.first(where: { $0.date.startOfDay == emptyDay.date.startOfDay }) {
                
                return ChartDay(
                    dailyGoal: existingDay.dailyGoal,
                    currentAmount: existingDay.currentAmount,
                    date: existingDay.date,
                    unit: existingDay.unit
                )
            } else {
                return ChartDay(
                    dailyGoal: emptyDay.dailyGoal,
                    currentAmount: emptyDay.currentAmount,
                    date: emptyDay.date,
                    unit: emptyDay.unit
                )
            }
            
        }
    }
    
    private func generateEmptyChartDays(count: Int = 31) -> [ChartDay] {
        (1..<count).map { chartDayGenerator.generateEmptyChartDay($0) }
    }
    
    private func deleteAllChartDays() {
        dataSource.deleteAllChartDays()
        chartDays = []
    }
}
