//
//  HydrationInputViewModel.swift
//  Hydration App
//
//  Created by Paraschiv, Darius on 11.08.2025.
//

import Foundation

class HydrationInputViewModel: ObservableObject {
    private let userDefaultsKey: String
    private let notificationName: Notification.Name
    
    @Published var initialValue: Int
    @Published var unit: UnitType
    
    init(initialValue: Int, userDefaultsKey: String, notificationName: Notification.Name, unit: UnitType) {
        self.initialValue = initialValue
        self.userDefaultsKey = userDefaultsKey
        self.notificationName = notificationName
        self.unit = unit
    }
    
    func saveValue(_ newValue: Int) {
        initialValue = newValue
        UserDefaults.standard.set(newValue, forKey: userDefaultsKey)
        NotificationCenter.default.post(name: notificationName, object: nil)
    }
}
