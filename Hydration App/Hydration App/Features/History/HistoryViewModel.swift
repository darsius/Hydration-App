//
//  History-ViewModel.swift
//  Hydration App
//
//  Created by Paraschiv, Darius on 05.08.2025.
//

import Foundation

@MainActor
class HistoryViewModel: ObservableObject {
    var maxDailyGoal: Int {
        chartDays.map { $0.currentAmount }.max() ?? Defaults.dailyGoal
    }
    
    @Published var chartDays: [ChartDay] = []
    
    private let dataSource: ChartDayDataSource
    private let chartDayGenerator: ChartDayGenerator
    
    init(dataSource: ChartDayDataSource, chartDayGenerator: ChartDayGenerator) {
        self.dataSource = dataSource
        self.chartDayGenerator = chartDayGenerator
        
//                deleteAllChartDays()
        generateInitialChartDays(count: 2)
        
        NotificationCenter.default.addObserver(self, selector: #selector(unitChanged(_:)), name: .unitDidChange, object: nil)
    }
    
    @objc func unitChanged(_ notification: Notification?) {
        let newUnit = UserDefaults.standard.string(forKey: UserDefaultsKeys.unit) ?? "ml"
        
        Task {
            dataSource.updateUnitForAllChartDays(to: newUnit)
            let hydrationDays = dataSource.fetchChartDays()
            chartDays = mapHydrationDaysToChartDays(hydrationDays)
        }
    }
}

private extension HistoryViewModel {
    private func generateInitialChartDays(count: Int = 30) {
        var hydrationDays = dataSource.fetchChartDays()
        
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
