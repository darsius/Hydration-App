//
//  HydrationViewModel.swift
//  Hydration App
//
//  Created by Paraschiv, Darius on 28.07.2025.
//

import Foundation
import SwiftData

@Observable
class TodayViewModel {
    private let userDefaults = UserDefaults.standard
    private let dataSource: ChartDayDataSource
    
    var dailyGoal: Int {
        didSet {
            userDefaults.set(dailyGoal, forKey: UserDefaultsKeys.dailyGoal)
            Task { @MainActor in
                saveCurrentDay()
            }
        }
    }
    
    var currentAmount: Int {
        didSet {
            userDefaults.setValue(currentAmount, forKey: UserDefaultsKeys.currentAmount)
            Task { @MainActor in
                saveCurrentDay()
            }
        }
    }
    
    var container1: Int {
        didSet {
            userDefaults.set(container1, forKey: UserDefaultsKeys.container1)
        }
    }
    
    var container2: Int {
        didSet {
            userDefaults.set(container2, forKey: UserDefaultsKeys.container2)
        }
    }
    
    var container3: Int {
        didSet {
            userDefaults.set(container3, forKey: UserDefaultsKeys.container3)
        }
    }
    
    var unit: UnitType {
        didSet {
            userDefaults.set(unit.rawValue, forKey: UserDefaultsKeys.unit)
            Task { @MainActor in
                saveCurrentDay()
            }
        }
    }
    
    init(dataSource: ChartDayDataSource) {
//        Self.clearUserDefaults()
        
        Self.setDefaulValues()
        
        
        dailyGoal = userDefaults.integer(forKey: UserDefaultsKeys.dailyGoal)
        currentAmount = userDefaults.integer(forKey: UserDefaultsKeys.currentAmount)
        container1 = userDefaults.integer(forKey: UserDefaultsKeys.container1)
        container2 = userDefaults.integer(forKey: UserDefaultsKeys.container2)
        container3 = userDefaults.integer(forKey: UserDefaultsKeys.container3)
        unit = UnitType(rawValue: userDefaults.string(forKey: UserDefaultsKeys.unit) ?? "") ?? .ml
        
        self.dataSource = dataSource
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
                    try context.save()
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
                try context.save()
            }
        } catch {
            print("error\(error.localizedDescription)")
        }
    }
    
    func convertCurrentAmount(from oldUnit: UnitType, to newUnit: UnitType) {
        currentAmount = Converter.convert(amount: currentAmount, for: UserDefaultsKeys.currentAmount, from: oldUnit, to: newUnit)
    }
    
    private static func setDefaulValues() {
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
