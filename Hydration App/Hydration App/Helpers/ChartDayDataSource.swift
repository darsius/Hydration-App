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
    func insert(_ entity: ChartDay) {
        self.container?.mainContext.insert(entity)
        try? self.container?.mainContext.save()
    }
    
    func fetchChartDays() -> [ChartDay] {
        let fetchDescriptor = FetchDescriptor<ChartDay>(
            sortBy: [SortDescriptor(\ChartDay.date)])
        let chartDays = try? self.container?.mainContext.fetch(fetchDescriptor)
        return chartDays ?? []
    }
    
    func deleteAllCharDays() {
        let fetchDescriptor = FetchDescriptor<ChartDay>()
        if let chartDays = try? self.container?.mainContext.fetch(fetchDescriptor) {
            chartDays.forEach { self.container?.mainContext.delete($0) }
            try? self.context?.save()
        }
    }
}
