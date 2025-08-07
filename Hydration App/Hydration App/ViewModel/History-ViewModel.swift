//
//  History-ViewModel.swift
//  Hydration App
//
//  Created by Paraschiv, Darius on 05.08.2025.
//

import Foundation

struct ChartDay: Identifiable {
    var id: Int
    var dailyGoal: Int
    var currentAmount: Int
    var date: Date
    var unit: String
}

extension ChartDay {
    var goalPrecentage: Int {
        guard dailyGoal > 0 else { return 0 }
        return min(100, Int(Double(currentAmount) / Double(dailyGoal) * 100))
    }
}

class HistoryViewModel: ObservableObject {
    private let dataSource: ChartDayDataSource
    private let chartDayGenerator: ChartDayGenerator
    
    private var hydrationDays: [HydrationDay] = []
    @Published var chartDays: [ChartDay] = []
    
    
    private var hasGeneratedInitialDays = false
    var hasOnlyEmptyDays = true
    
    var maxDailyGoal: Int {
        hydrationDays.map { $0.dailyGoal }.max() ?? 2000
    }
    
    init(dataSource: ChartDayDataSource, chartDayGenerator: ChartDayGenerator) {
        self.dataSource = dataSource
        self.chartDayGenerator = chartDayGenerator
        
        Task { @MainActor in
//            dataSource.deleteAllChartDays()
            generateInitialChartDays(count: 5)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(unitChanged(_:)), name: Notification.Name("unitChanged"), object: nil)
    }
    
    @objc func unitChanged(_ notification: Notification) {
        let newUnit = UserDefaults.standard.string(forKey: "selectedUnit") ?? "ml"
        print("noul unit este \(newUnit)")
        
        Task { @MainActor in
            dataSource.updateUnitForAllChartDays(to: newUnit)
            hydrationDays = dataSource.fetchChartDays()
            chartDays = mapHydrationDaysToChartDays(hydrationDays)
        }
    }
    
    @MainActor func generateInitialChartDays(count: Int = 30) {
        hydrationDays = dataSource.fetchChartDays()
        
        if hydrationDays.isEmpty {
            for i in 0..<count {
                let day = chartDayGenerator.generateRandomChartDay(i)
                dataSource.insert(day)
            }
        }
        
        chartDays = mapHydrationDaysToChartDays(hydrationDays)
    }
    
    
    func generateEmptyChartDays(count: Int = 30) -> [HydrationDay] {
        (0..<count).map { chartDayGenerator.generateEmptyChartDay($0) }
    }
    
    func mapHydrationDaysToChartDays(_ days: [HydrationDay]) -> [ChartDay] {
        let emptyDays = generateEmptyChartDays()
        return emptyDays.map { emptyDay in
            if let existingDay = days.first(where: { $0.date.startOfDay == emptyDay.date.startOfDay }) {

                return ChartDay(
                    id: existingDay.identity,
                    dailyGoal: existingDay.dailyGoal,
                    currentAmount: existingDay.currentAmount,
                    date: existingDay.date,
                    unit: existingDay.unit
                )
            } else {
                return ChartDay(
                    id: emptyDay.identity,
                    dailyGoal: emptyDay.dailyGoal,
                    currentAmount: emptyDay.currentAmount,
                    date: emptyDay.date,
                    unit: emptyDay.unit
                )
            }
            
        }
    }
    
    @MainActor func deleteAllChartDays() {
        dataSource.deleteAllChartDays()
        chartDays = []
        hydrationDays = []
    }
}
