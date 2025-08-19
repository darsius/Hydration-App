//
//  AppCoordinator.swift
//  Hydration App
//
//  Created by Paraschiv, Darius on 13.08.2025.
//
import Foundation
import SwiftUICore
import SwiftData

@MainActor
final class AppCoordinator {
    let dataSource: ChartDayDataSource
    let chartDayGenerator: ChartDayGenerator
    
    init(container: ModelContainer) {
        self.dataSource = ChartDayDataSource(container: container)
        self.chartDayGenerator = ChartDayGenerator()
    }
    
    func makeTodayView() -> some View {
        TodayView(viewModel: TodayViewModel(dataSource: self.dataSource),
                  coordinator: self)
    }
    
    func makeHistoryView() -> some View {
        HistoryView(viewModel: HistoryViewModel(
            dataSource: self.dataSource,
            chartDayGenerator: self.chartDayGenerator))
    }
    
    func makeSettingsView() -> some View {
        SettingsView(viewModel: SettingsViewModel(),
                     coordinator: self)
    }
    
    func makeUnitsView(unit: UnitType) -> some View {
        UnitsView(viewModel: UnitsViewModel(selectedUnit: unit))
    }
    
    func makeInputView(initialValue: Int, inputType: HydrationType, unit: UnitType) -> some View {
        HydrationInputView(
            viewModel: HydrationInputViewModel(
                initialValue: initialValue,
                inputType: inputType,
                unit: unit),
            viewType: inputType.hydrationViewType
        )
    }
}
