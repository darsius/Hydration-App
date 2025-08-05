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
    
    @Published var chartDays: [ChartDay] = []
    
    init(dataSource: ChartDayDataSource, chartDayGenerator: ChartDayGenerator) {
        self.dataSource = dataSource
        self.chartDayGenerator = chartDayGenerator
        
        Task { @MainActor in
            chartDays = dataSource.fetchChartDays()
            print("avem in VM atatea chartDays: \(chartDays.count)")
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
            dataSource.deleteAllCharDays()
            chartDays = []
            print("S au sters toate ")
        }
    }
}
