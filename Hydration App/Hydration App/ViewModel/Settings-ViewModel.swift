//
//  Settings-ViewModel.swift
//  Hydration App
//
//  Created by Paraschiv, Darius on 01.08.2025.
//

import Foundation

@Observable
class SettingsViewModel {
    func convertAll(
        dailyGoal: inout Int,
        container1: inout Int,
        container2: inout Int,
        container3: inout Int,
        from oldUnit: String,
        to newUnit: String
    ) {
        Converter.convertAll(
            dailyGoal: &dailyGoal,
            container1: &container1,
            container2: &container2,
            container3: &container3,
            from: oldUnit,
            to: newUnit)
    }
}
