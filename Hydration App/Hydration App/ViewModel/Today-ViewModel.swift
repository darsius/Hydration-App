//
//  HydrationViewModel.swift
//  Hydration App
//
//  Created by Paraschiv, Darius on 28.07.2025.
//

import Foundation

@Observable
class TodayViewModel {
    private let storageKey = "TodayProgress"
    
    private(set) var model: TodayProgress {
        didSet {
            saveToUserDefaults()
        }
    }
    
    init() {
//        Self.clearUserDefaults()
        self.model = Self.loadFromUserDefaults() ?? TodayProgress(dailyGoal: 2000, currentAmount: 100)
    }
    
    var dailyGoal: Int {
        get { model.dailyGoal }
        set {
            model = TodayProgress(dailyGoal: newValue, currentAmount: currentAmount)
        }
    }
    
    var currentAmount: Int {
        get { model.currentAmount }
        set {
            model.currentAmount = newValue
        }
    }
    
    var currentGoalPrecentage: Double {
        guard model.dailyGoal > 0 else { return 0 }
        return Double(model.currentAmount) / Double(model.dailyGoal) * 100
    }
    
    func addAmount(amount: Int) {
        model.currentAmount += amount
        saveToUserDefaults()
    }
    
    private func saveToUserDefaults() {
        if let data = try? JSONEncoder().encode(model) {
            UserDefaults.standard.set(data, forKey: storageKey)
        }
    }
    
    private static func loadFromUserDefaults() -> TodayProgress? {
        guard let data = UserDefaults.standard.data(forKey: "TodayProgress") else { return nil }
        return try? JSONDecoder().decode(TodayProgress.self, from: data)
    }
    
    static func clearUserDefaults() {
        UserDefaults.standard.removeObject(forKey: "TodayProgress")
        UserDefaults.standard.removeObject(forKey: "HydrationInputAmount_dailyGoal")
        UserDefaults.standard.removeObject(forKey: "HydrationInputAmount_container1")
        UserDefaults.standard.removeObject(forKey: "HydrationInputAmount_container2")
        UserDefaults.standard.removeObject(forKey: "HydrationInputAmount_container3")
    }
}
