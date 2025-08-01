//
//  HydrationViewModel.swift
//  Hydration App
//
//  Created by Paraschiv, Darius on 28.07.2025.
//

import Foundation

@Observable
class TodayViewModel {
    var dailyGoal: Int {
        didSet {
            UserDefaults.standard.set(dailyGoal, forKey: "dailyGoal")
            NotificationCenter.default.post(name: .dailyGoalChanged, object: nil)
        }
    }
    
    var currentAmount: Int {
        didSet {
            UserDefaults.standard.setValue(currentAmount, forKey: "currentAmount")
        }
    }
    
    var container1: Int {
        didSet {
            UserDefaults.standard.set(container1, forKey: "container1")
            NotificationCenter.default.post(name: .container1Changed, object: nil)
        }
    }
    
    var container2: Int {
        didSet {
            UserDefaults.standard.set(container2, forKey: "container2")
            NotificationCenter.default.post(name: .container2Changed, object: nil)
        }
    }
    
    var container3: Int {
        didSet {
            UserDefaults.standard.set(container3, forKey: "container3")
        }
    }

    var unit: String {
        didSet {
            UserDefaults.standard.set(unit, forKey: "unit")
        }
    }
    
    init() {
        Self.clearUserDefaults()
        
        let defaults = UserDefaults.standard
        let dict = defaults.dictionaryRepresentation()
        print("UserDefaults conținut:")
        for (key, value) in dict {
            if (key == "dailyGoal" || key == "currentAmount" || key == "container1" || key == "container2" || key == "container3" || key == "unit") {
                print("\(key): \(value)")
            }
        }
        
        let userDefaults = UserDefaults.standard
        
        if userDefaults.object(forKey: "dailyGoal") == nil {
            userDefaults.set(2000, forKey: "dailyGoal")
        }
        
        dailyGoal = userDefaults.integer(forKey: "dailyGoal") 
        currentAmount = userDefaults.integer(forKey: "currentAmount")
        container1 = userDefaults.integer(forKey: "container1")
        container2 = userDefaults.integer(forKey: "container2")
        container3 = userDefaults.integer(forKey: "container3")
        unit = userDefaults.string(forKey: "unit") ?? "ml"
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateDailyGoal), name: .dailyGoalChanged, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateContainer1), name: .container1Changed, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateContainer2), name: .container2Changed, object: nil)
    }
    
    @objc private func updateDailyGoal() {
        let storedAmount = UserDefaults.standard.object(forKey: "dailyGoal") as? Int ?? 2000
        if storedAmount != dailyGoal {
            self.dailyGoal = storedAmount
        }
    }
    
    @objc private func updateContainer1() {
        let storedAmount = UserDefaults.standard.object(forKey: "container1") as? Int ?? 100
        if storedAmount != container1 {
            self.container1 = storedAmount
        }
    }
    
    @objc private func updateContainer2() {
        let storedAmount = UserDefaults.standard.object(forKey: "container2") as? Int ?? 200
        if storedAmount != container2 {
            self.container2 = storedAmount
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func addAmount(amount: Int) {
        currentAmount += amount
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
    static let container1Changed = Notification.Name("container1Changed")
    static let container2Changed = Notification.Name("container2Changed")
    static let container3Changed = Notification.Name("container3Changed")
}
