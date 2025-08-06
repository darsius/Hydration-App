//
//  History-ViewModel.swift
//  Hydration App
//
//  Created by Paraschiv, Darius on 05.08.2025.
//

import Foundation

class HistoryViewModel: ObservableObject {
    private let dataSource: ChartDayDataSource
    private let chartDayGenerator: ChartDayGenerator
        
    @Published var chartDays: [HydrationDay] = []

    var maxDailyGoal: Int {
        chartDays.map { $0.dailyGoal }.max() ?? 2000
    }
        
    init(dataSource: ChartDayDataSource, chartDayGenerator: ChartDayGenerator) {
        self.dataSource = dataSource
        self.chartDayGenerator = chartDayGenerator
        
        Task { @MainActor in
            chartDays = dataSource.fetchChartDays()
            chartDays = allDays(from: chartDays)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(unitChanged(_:)), name: Notification.Name("unitChanged"), object: nil)
    }
    
    @objc func unitChanged(_ notification: Notification) {
        let newUnit = UserDefaults.standard.string(forKey: "selectedUnit") ?? "ml"
        print("noul unit este \(newUnit)")
        
        Task { @MainActor in
            dataSource.updateUnitForAllChartDays(to: newUnit)
            chartDays = allDays(from: dataSource.fetchChartDays())
        }
    }
    
    func didGenerateRandomChartDay() {
        Task { @MainActor in
            let nextDay = chartDays.count
            dataSource.insert(chartDayGenerator.generateRandomChartDay(nextDay))
            chartDays = dataSource.fetchChartDays()
        }
    }
    
    func didGenerateEmptyChartDay() {
        Task { @MainActor in
            let nextDay = chartDays.count
            dataSource.insert(chartDayGenerator.generateEmptyChartDay(nextDay))
            chartDays = dataSource.fetchChartDays()
        }
    }
    
    @MainActor func generateInitialChartDays(count: Int = 30) {
        let existingDays = dataSource.fetchChartDays()
        guard existingDays.isEmpty else { return }
        for i in 0..<count {
            let day = chartDayGenerator.generateRandomChartDay(i)
            dataSource.insert(day)
        }
        chartDays = dataSource.fetchChartDays()
    }
    
    func deleteAllChartDays() {
        Task { @MainActor in
            dataSource.deleteAllChartDays()
            chartDays = []
        }
    }
    
    func generateEmptyChartDays(count: Int = 30) -> [HydrationDay] {
        (0..<count).map { chartDayGenerator.generateEmptyChartDay($0) }
    }
    
    func allDays(from existingDays: [HydrationDay]) -> [HydrationDay] {
        var i = 0
        let existingDict = Dictionary(uniqueKeysWithValues: existingDays.map { ($0.date.startOfDay, $0) })

        return generateEmptyChartDays().map { emptyDay in
            if let existing = existingDict[emptyDay.date.startOfDay] {
                return existing
            } else {
                i += 1
                print(i)
                return emptyDay
            }
        }
    }
}
