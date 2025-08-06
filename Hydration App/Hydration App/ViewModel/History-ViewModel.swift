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
        
    @Published var hydrationDays: [HydrationDay] = []
    
    private var hasGeneratedInitialDays = false
    var hasOnlyEmptyDays = true

    var maxDailyGoal: Int {
        hydrationDays.map { $0.dailyGoal }.max() ?? 2000
    }
        
    init(dataSource: ChartDayDataSource, chartDayGenerator: ChartDayGenerator) {
        self.dataSource = dataSource
        self.chartDayGenerator = chartDayGenerator
        
        Task { @MainActor in
            hydrationDays = dataSource.fetchChartDays()
            hydrationDays = allDays(from: hydrationDays)
            generateInitialChartDays(count: 4)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(unitChanged(_:)), name: Notification.Name("unitChanged"), object: nil)
    }
    
    @objc func unitChanged(_ notification: Notification) {
        let newUnit = UserDefaults.standard.string(forKey: "selectedUnit") ?? "ml"
        print("noul unit este \(newUnit)")
        
        Task { @MainActor in
            dataSource.updateUnitForAllChartDays(to: newUnit)
            hydrationDays = allDays(from: dataSource.fetchChartDays())
        }
    }
    
    @MainActor func didGenerateRandomChartDay() {
        let nextDay = hydrationDays.count
        dataSource.insert(chartDayGenerator.generateRandomChartDay(nextDay))
        hydrationDays = allDays(from: dataSource.fetchChartDays())
    }
    
    @MainActor func didGenerateEmptyChartDay() {
        let nextDay = hydrationDays.count
        dataSource.insert(chartDayGenerator.generateEmptyChartDay(nextDay))
        hydrationDays = allDays(from: dataSource.fetchChartDays())
    }
    
    @MainActor func generateInitialChartDays(count: Int = 30) {
        guard !hasGeneratedInitialDays else { return }
        hasGeneratedInitialDays = true
        print("**")
        for i in 0..<count {
            let day = chartDayGenerator.generateRandomChartDay(i)
            dataSource.insert(day)
        }
        hydrationDays = allDays(from: dataSource.fetchChartDays())
    }
    
    @MainActor func deleteAllChartDays() {
        dataSource.deleteAllChartDays()
        hydrationDays = []
    }

    
    func generateEmptyChartDays(count: Int = 30) -> [HydrationDay] {
        (0..<count).map { chartDayGenerator.generateEmptyChartDay($0) }
    }
    
    func allDays(from existingDays: [HydrationDay]) -> [HydrationDay] {
        let existingDict = Dictionary(uniqueKeysWithValues: existingDays.map { ($0.date.startOfDay, $0) })

        return generateEmptyChartDays().map { emptyDay in
            if let existing = existingDict[emptyDay.date.startOfDay] {
                hasOnlyEmptyDays = false
                return existing
            } else {
                return emptyDay
            }
        }
    }
}
