//
//  HydrationViewModel.swift
//  Hydration App
//
//  Created by Paraschiv, Darius on 28.07.2025.
//

import Foundation

@Observable
class TodayViewModel {
    
    var container1: Int {
        didSet {
            UserDefaults.standard.set(container1, forKey: "container1")
            NotificationCenter.default.post(name: .dailyGoalChanged, object: nil)
        }
    }
    
    var container2: Int {
        didSet {
            UserDefaults.standard.set(container2, forKey: "container2")
        }
    }
    
    var container3: Int {
        didSet {
            UserDefaults.standard.set(container3, forKey: "container3")
        }
    }
    
    var dailyGoal: Int {
        didSet {
            UserDefaults.standard.set(dailyGoal, forKey: "dailyGoal")
        }
    }
    
    var currentAmount: Int {
        didSet {
            saveCurrentAmount(currentAmount)
        }
    }
    
    var unit: String {
        didSet {
            UserDefaults.standard.set(unit, forKey: "unit")
        }
    }
    
    init() {
        //        Self.clearUserDefaults()
        
        let defaults = UserDefaults.standard
        let dict = defaults.dictionaryRepresentation()
        print("UserDefaults conținut:")
        for (key, value) in dict {
            if (key == "dailyGoal" || key == "currentAmount" || key == "container1" || key == "container2" || key == "container3" || key == "unit") {
                print("\(key): \(value)")
            }
        }
        
        dailyGoal = UserDefaults.standard.object(forKey: "dailyGoal") as? Int ?? 2000
        currentAmount = UserDefaults.standard.object(forKey: "currentAmount") as? Int ?? 0
        container1 = UserDefaults.standard.object(forKey: "container1") as? Int ?? 100
        container2 = UserDefaults.standard.object(forKey: "container2") as? Int ?? 200
        container3 = UserDefaults.standard.object(forKey: "container3") as? Int ?? 400
        unit = UserDefaults.standard.string(forKey: "unit") ?? "ml"
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateDailyGoal), name: .dailyGoalChanged, object: nil)
    }
    
    @objc private func updateDailyGoal() {
        let stored = UserDefaults.standard.object(forKey: "dailyGoal") as? Int ?? 2000
        if stored != dailyGoal {
            self.dailyGoal = stored
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func addAmount(amount: Int) {
        currentAmount += amount
    }
    
    private func saveCurrentAmount(_ amount: Int) {
        UserDefaults.standard.setValue(amount, forKey: "currentAmount")
    }
    
    var goalPrecentage: Double {
        guard dailyGoal > 0 else { return 0 }
        return Double(currentAmount) / Double(dailyGoal) * 100
    }
    
    static func clearUserDefaults() {
        UserDefaults.standard.removeObject(forKey: "dailyGoal")
        UserDefaults.standard.removeObject(forKey: "currentAmount")
        UserDefaults.standard.removeObject(forKey: "container1")
        UserDefaults.standard.removeObject(forKey: "container2")
        UserDefaults.standard.removeObject(forKey: "container3")
        UserDefaults.standard.removeObject(forKey: "unit")
    }
}

extension Notification.Name {
    static let dailyGoalChanged = Notification.Name("dailyGoalChanged")
}
