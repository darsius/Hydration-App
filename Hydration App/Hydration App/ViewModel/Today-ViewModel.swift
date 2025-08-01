//
//  HydrationViewModel.swift
//  Hydration App
//
//  Created by Paraschiv, Darius on 28.07.2025.
//

import Foundation

@Observable
class TodayViewModel {
    private let userDefaults = UserDefaults.standard
    
    var dailyGoal: Int {
        didSet {
            userDefaults.set(dailyGoal, forKey: "dailyGoal")
            NotificationCenter.default.post(name: .dailyGoalChanged, object: nil)
        }
    }
    
    var currentAmount: Int {
        didSet {
            userDefaults.setValue(currentAmount, forKey: "currentAmount")
        }
    }
    
    var container1: Int {
        didSet {
            userDefaults.set(container1, forKey: "container1")
            NotificationCenter.default.post(name: .container1Changed, object: nil)
        }
    }
    
    var container2: Int {
        didSet {
            userDefaults.set(container2, forKey: "container2")
            NotificationCenter.default.post(name: .container2Changed, object: nil)
        }
    }
    
    var container3: Int {
        didSet {
            userDefaults.set(container3, forKey: "container3")
        }
    }

    var unit: String {
        didSet {
            userDefaults.set(unit, forKey: "unit")
        }
    }
    
    init() {
//        Self.clearUserDefaults()
        
        let dict = userDefaults.dictionaryRepresentation()
        print("UserDefaults continut:")
        for (key, value) in dict {
            if (key == "dailyGoal" || key == "currentAmount" || key == "container1" || key == "container2" || key == "container3" || key == "unit") {
                print("\(key): \(value)")
            }
        }
        
        if userDefaults.object(forKey: "dailyGoal") == nil {
            userDefaults.set(2000, forKey: "dailyGoal")
        }
        
        if userDefaults.object(forKey: "container1") == nil {
            userDefaults.set(100, forKey: "container1")
        }
        
        if userDefaults.object(forKey: "container2") == nil {
            userDefaults.set(200, forKey: "container2")
        }
        
        if userDefaults.object(forKey: "container3") == nil {
            userDefaults.set(400, forKey: "container3")
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
        NotificationCenter.default.addObserver(self, selector: #selector(updateContainer3), name: .container3Changed, object: nil)
    }
    
    @objc private func updateDailyGoal() {
        let storedAmount = userDefaults.integer(forKey: "dailyGoal")
        if storedAmount != dailyGoal {
            self.dailyGoal = storedAmount
        }
    }
    
    @objc private func updateContainer1() {
        let storedAmount = userDefaults.integer(forKey: "container1")
        if storedAmount != container1 {
            self.container1 = storedAmount
        }
    }
    
    @objc private func updateContainer2() {
        let storedAmount = userDefaults.integer(forKey: "container2")
        if storedAmount != container2 {
            self.container2 = storedAmount
        }
    }
    
    @objc private func updateContainer3() {
        let storedAmount = userDefaults.integer(forKey: "container3")
        if storedAmount != container3 {
            self.container3 = storedAmount
        }
    }
    
    func addAmount(amount: Int) {
        currentAmount += amount
    }
    
    var goalPrecentage: Double {
        guard dailyGoal > 0 else { return 0 }
        return Double(currentAmount) / Double(dailyGoal) * 100
    }
    
    func clearUserDefaults() {
        UserDefaults.standard.removeObject(forKey: "dailyGoal")
        UserDefaults.standard.removeObject(forKey: "currentAmount")
        UserDefaults.standard.removeObject(forKey: "container1")
        UserDefaults.standard.removeObject(forKey: "container2")
        UserDefaults.standard.removeObject(forKey: "container3")
        UserDefaults.standard.removeObject(forKey: "unit")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension Notification.Name {
    static let dailyGoalChanged = Notification.Name("dailyGoalChanged")
    static let container1Changed = Notification.Name("container1Changed")
    static let container2Changed = Notification.Name("container2Changed")
    static let container3Changed = Notification.Name("container3Changed")
}
