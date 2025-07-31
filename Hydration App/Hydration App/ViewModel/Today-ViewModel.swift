//
//  HydrationViewModel.swift
//  Hydration App
//
//  Created by Paraschiv, Darius on 28.07.2025.
//

import Foundation

@Observable
class TodayViewModel {
    
    
    
//    var container1: Int = UserDefaults.standard.integer(forKey: "dailyGoal") {
//        didSet {
//            print("container 1 va avea cantitatea: \(container1)")
//            UserDefaults.standard.set(container1, forKey: "dailyGoal")
//        }
//    }
//    private var _container1: Int = 0
//    
//    var container1: Int {
//        get { _container1 }
//        set {
//            _container1 = newValue
//            UserDefaults.standard.set(newValue, forKey: "container1")
//        }
//    }
    
    var container1: Int {
        didSet {
            UserDefaults.standard.set(container1, forKey: "container1")
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
    
    init() {
//        Self.clearUserDefaults()
        
//        let defaults = UserDefaults.standard
//        let dict = defaults.dictionaryRepresentation()
//        print("UserDefaults conținut:")
//        for (key, value) in dict {
//            if (key == "dailyGoal" || key == "currentAmount" || key == "container1" || key == "container2" || key == "container3") {
//                print("\(key): \(value)")
//            }
//        }
//        
        container1 = UserDefaults.standard.object(forKey: "container1") as? Int ?? 100
        container2 = UserDefaults.standard.object(forKey: "container2") as? Int ?? 200
        container3 = UserDefaults.standard.object(forKey: "container3") as? Int ?? 400
    }
    
    // TODO: check for dailyGoal = 0
    var dailyGoal: Int = UserDefaults.standard.integer(forKey: "dailyGoal") {
        didSet {
            UserDefaults.standard.set(dailyGoal, forKey: "dailyGoal")
        }
    }
    
    var currentAmount: Int = UserDefaults.standard.integer(forKey: "currentAmount") {
        didSet {
            saveCurrentAmount(currentAmount)
        }
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
    }
}
