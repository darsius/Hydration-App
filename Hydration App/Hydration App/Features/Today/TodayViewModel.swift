//
//  HydrationViewModel.swift
//  Hydration App
//
//  Created by Paraschiv, Darius on 28.07.2025.
//

import Foundation
import SwiftData

@MainActor
class TodayViewModel: ObservableObject {
    var goalPrecentage: Double {
        guard dailyGoal > 0 else { return 0 }
        return Double(currentAmount) / Double(dailyGoal) * 100
    }
    
    @Published var dailyGoal: Int {
        didSet {
            saveCurrentDay()
        }
    }
    
    @Published var currentAmount: Int {
        didSet {
            userDefaults.setValue(currentAmount, forKey: UserDefaultsKeys.currentAmount)
            saveCurrentDay()
        }
    }
    
    @Published var unit: UnitType {
        didSet {
            userDefaults.set(unit.rawValue, forKey: UserDefaultsKeys.unit)
            saveCurrentDay()
        }
    }
    
    @Published var container1: Int
    @Published var container2: Int
    @Published var container3: Int
    
    private let userDefaults = UserDefaults.standard
    private let dataSource: ChartDayDataSource
    
    init(dataSource: ChartDayDataSource) {
        //        Self.clearUserDefaults()
        Self.setDefaultValues()
        
        dailyGoal = userDefaults.integer(forKey: UserDefaultsKeys.dailyGoal)
        currentAmount = userDefaults.integer(forKey: UserDefaultsKeys.currentAmount)
        container1 = userDefaults.integer(forKey: UserDefaultsKeys.container1)
        container2 = userDefaults.integer(forKey: UserDefaultsKeys.container2)
        container3 = userDefaults.integer(forKey: UserDefaultsKeys.container3)
        unit = UnitType(rawValue: userDefaults.string(forKey: UserDefaultsKeys.unit) ?? "") ?? .ml
        
        self.dataSource = dataSource
        
        if isNewDay() {
            currentAmount = 0
            userDefaults.set(0, forKey: UserDefaultsKeys.currentAmount)
        }
        
        userDefaults.set(Date().startOfDay, forKey: UserDefaultsKeys.lastDay)
        
        NotificationCenter.default.addObserver(self, selector: #selector(unitChanged(_:)), name: .unitDidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(dailyGoalChanged(_:)), name: .dailyGoalDidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(container1Changed(_:)), name: .container1DidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(container2Changed(_:)), name: .container2DidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(container3Changed(_:)), name: .container3DidChange, object: nil)
    }
    
    @objc func container3Changed(_ notification: Notification) {
        let newValue = userDefaults.integer(forKey: UserDefaultsKeys.container3)
        container3 = newValue
    }
    
    @objc func container2Changed(_ notification: Notification) {
        let newValue = userDefaults.integer(forKey: UserDefaultsKeys.container2)
        container2 = newValue
    }
    
    @objc func container1Changed(_ notification: Notification) {
        let newValue = userDefaults.integer(forKey: UserDefaultsKeys.container1)
        container1 = newValue
    }
    
    @objc func dailyGoalChanged(_ notification: Notification) {
        let newValue = userDefaults.integer(forKey: UserDefaultsKeys.dailyGoal)
        dailyGoal = newValue
    }
    
    @objc func unitChanged(_ notification: Notification) {
        let oldUnit = unit
        guard let newUnitRaw = UserDefaults.standard.string(forKey: UserDefaultsKeys.unit),
              let newUnit = UnitType(rawValue: newUnitRaw),
              newUnit != oldUnit else {
            return
        }
        
        currentAmount = Converter.convert(amount: currentAmount, from: oldUnit, to: newUnit)
        
        Converter.convertAll(
            dailyGoal: &dailyGoal,
            container1: &container1,
            container2: &container2,
            container3: &container3,
            from: oldUnit,
            to: newUnit)
        
        saveToUserDefaults(
            currentAmount: currentAmount,
            dailyGoal: dailyGoal,
            container1: container1,
            container2: container2,
            container3: container3,
            unit: newUnit)
        
        unit = newUnit
    }
    
    func addAmount(amount: Int) {
        currentAmount += amount
    }
}

private extension TodayViewModel {
    func isNewDay() -> Bool {
        let today = Date().startOfDay
        if let lastDay = userDefaults.object(forKey: UserDefaultsKeys.lastDay) as? Date {
            return !Calendar.current.isDate(today, inSameDayAs: lastDay)
        }
        return true
    }
    
    func saveCurrentDay() {
        let todayDate = Date().startOfDay
        
        let existingDay = dataSource.fetchChartDays().first { $0.date == todayDate }
        
        if let existingDay {
            existingDay.dailyGoal = dailyGoal
            existingDay.currentAmount = currentAmount
            existingDay.unit = unit.rawValue
        } else {
            if currentAmount > 0 {
                let newDay = HydrationDay(
                    dailyGoal: dailyGoal,
                    currentAmount: currentAmount,
                    date: todayDate,
                    unit: unit.rawValue
                )
                dataSource.insert(newDay)
            }
        }
    }
    
    func saveToUserDefaults(
        currentAmount: Int,
        dailyGoal: Int,
        container1: Int,
        container2: Int,
        container3: Int,
        unit: UnitType
    ) {
        userDefaults.set(currentAmount, forKey: UserDefaultsKeys.currentAmount)
        userDefaults.set(dailyGoal, forKey: UserDefaultsKeys.dailyGoal)
        userDefaults.set(container1, forKey: UserDefaultsKeys.container1)
        userDefaults.set(container2, forKey: UserDefaultsKeys.container2)
        userDefaults.set(container3, forKey: UserDefaultsKeys.container3)
        userDefaults.set(unit.rawValue, forKey: UserDefaultsKeys.unit)
    }
    
    static func setDefaultValues() {
        let defaults: [String: Any] = [
            UserDefaultsKeys.dailyGoal: Defaults.dailyGoal,
            UserDefaultsKeys.currentAmount: Defaults.currentAmount,
            UserDefaultsKeys.container1: Defaults.container1,
            UserDefaultsKeys.container2: Defaults.container2,
            UserDefaultsKeys.container3: Defaults.container3,
            UserDefaultsKeys.unit: UnitType.ml.rawValue
        ]
        UserDefaults.standard.register(defaults: defaults)
    }
    
    static func clearUserDefaults() {
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.dailyGoal)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.currentAmount)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.container1)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.container2)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.container3)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.unit)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.lastDay)
    }
}
