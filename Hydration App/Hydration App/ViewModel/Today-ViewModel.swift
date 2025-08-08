//
//  HydrationViewModel.swift
//  Hydration App
//
//  Created by Paraschiv, Darius on 28.07.2025.
//

import Foundation
import SwiftData


class TodayViewModel: ObservableObject {
    private let userDefaults = UserDefaults.standard
    private let dataSource: ChartDayDataSource
    
    @Published var dailyGoal: Int {
        didSet {
            Task { @MainActor in
                saveCurrentDay()
            }
        }
    }
    
    @Published var currentAmount: Int {
        didSet {
            userDefaults.setValue(currentAmount, forKey: UserDefaultsKeys.currentAmount)
            Task { @MainActor in
                saveCurrentDay()
            }
        }
    }
    
    @Published var unit: UnitType {
        didSet {
            userDefaults.set(unit.rawValue, forKey: UserDefaultsKeys.unit)
            Task { @MainActor in
                saveCurrentDay()
            }
        }
    }
    
    @Published var container1: Int
    @Published var container2: Int
    @Published var container3: Int
    
    init(dataSource: ChartDayDataSource) {
//                Self.clearUserDefaults()
        
        Self.setDefaultValues()
        
        
        dailyGoal = userDefaults.integer(forKey: UserDefaultsKeys.dailyGoal)
        currentAmount = userDefaults.integer(forKey: UserDefaultsKeys.currentAmount)
        container1 = userDefaults.integer(forKey: UserDefaultsKeys.container1)
        container2 = userDefaults.integer(forKey: UserDefaultsKeys.container2)
        container3 = userDefaults.integer(forKey: UserDefaultsKeys.container3)
        unit = UnitType(rawValue: userDefaults.string(forKey: UserDefaultsKeys.unit) ?? "") ?? .ml
        
        self.dataSource = dataSource
        
        NotificationCenter.default.addObserver(self, selector: #selector(unitChanged(_:)), name: Notification.Name(UserDefaultsKeys.unit), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(dailyGoalChanged(_:)), name: Notification.Name(UserDefaultsKeys.dailyGoal), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(container1Changed(_:)), name: Notification.Name(UserDefaultsKeys.container1), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(container2Changed(_:)), name: Notification.Name(UserDefaultsKeys.container2), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(container3Changed(_:)), name: Notification.Name(UserDefaultsKeys.container3), object: nil)
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

        currentAmount = Converter.convert(amount: currentAmount, for: UserDefaultsKeys.currentAmount, from: oldUnit, to: newUnit)
        unit = newUnit
    }
    
    @MainActor func saveCurrentDay() {
        guard let context = ContextManager.shared.context else {
            print("no context")
            return
        }
        
        let todayDate = Date().startOfDay
        let fetchDescriptor = FetchDescriptor<HydrationDay>(predicate: #Predicate { $0.date == todayDate }
        )
        do {
            let results = try ContextManager.shared.context?.fetch(fetchDescriptor)
            
            if let existingDay = results?.first {
                if let model = context.registeredModel(for: existingDay.persistentModelID) as HydrationDay? {
                    model.dailyGoal = dailyGoal
                    model.currentAmount = currentAmount
                    model.unit = unit.rawValue
//                    try context.save()
                    print("il avem in db, facem update")
                }
            } else {
                print("se creeaza today")
                let newDay = HydrationDay(
                    dailyGoal: dailyGoal,
                    currentAmount: currentAmount,
                    date: todayDate,
                    unit: unit.rawValue
                )
                context.insert(newDay)
//                try context.save()
            }
        } catch {
            print("error\(error.localizedDescription)")
        }
    }
    
    private static func setDefaultValues() {
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
    
    
    func addAmount(amount: Int) {
        currentAmount += amount
    }
    
    var goalPrecentage: Double {
        guard dailyGoal > 0 else { return 0 }
        return Double(currentAmount) / Double(dailyGoal) * 100
    }
    
    static func clearUserDefaults() {
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.dailyGoal)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.currentAmount)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.container1)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.container2)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.container3)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.unit)
    }
}
