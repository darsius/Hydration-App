//
//  HydrationViewModel.swift
//  Hydration App
//
//  Created by Paraschiv, Darius on 28.07.2025.
//

import Foundation

@Observable
class TodayViewModel {
        
    init() {
//        Self.clearUserDefaults()
        
        let defaults = UserDefaults.standard
        let dict = defaults.dictionaryRepresentation()
        print("UserDefaults conținut:")
        for (key, value) in dict {
            if (key == "dailyGoal" || key == "currentAmount" || key == "container1" || key == "container2" || key == "container3") {
                print("\(key): \(value)")
            }
        }
        
    }
    
    var dailyGoal: Int = UserDefaults.standard.integer(forKey: "dailyGoal") {
           didSet {
               UserDefaults.standard.set(dailyGoal, forKey: "dailyGoal")
           }
       }
    
    var currentAmount: Int = UserDefaults.standard.integer(forKey: "currentAmount") {
        didSet {
            print("new value is: \(currentAmount)")
//            saveCurrentAmount(currentAmount)
        }
    }
    
    func addAmount(amount: Int) {
        currentAmount += amount
        saveCurrentAmount(currentAmount)
    }
    
    private func saveCurrentAmount(_ amount: Int) {
        UserDefaults.standard.setValue(amount, forKey: "currentAmount")
    }
//    
//    var currentGoalPrecentage: Double {
//        guard todayModel.dailyGoal > 0 else { return 0 }
//        return Double(todayModel.currentAmount) / Double(todayModel.dailyGoal) * 100
//    }
//
//    
//    private func saveToUserDefaults() {
//        if let data = try? JSONEncoder().encode(todayModel) {
//            UserDefaults.standard.set(data, forKey: storageKey)
//        }
//    }
    
//    private static func loadFromUserDefaults() -> TodayModel? {
//        guard let data = UserDefaults.standard.data(forKey: "dailyGoal") else { return nil }
//        return try? JSONDecoder().decode(TodayModel.self, from: data)
//    }
    
    static func clearUserDefaults() {
        UserDefaults.standard.removeObject(forKey: "dailyGoal")
        UserDefaults.standard.removeObject(forKey: "currentAmount")
        UserDefaults.standard.removeObject(forKey: "container1")
        UserDefaults.standard.removeObject(forKey: "container2")
        UserDefaults.standard.removeObject(forKey: "container3")
    }
}
