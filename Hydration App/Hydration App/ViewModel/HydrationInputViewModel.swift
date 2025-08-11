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
    
    @Published var value: Int
    
    init(initialValue: Int, userDefaultsKey: String, notificationName: Notification.Name) {
        self.value = initialValue
        self.userDefaultsKey = userDefaultsKey
        self.notificationName = notificationName
    }
    
    func saveValue(_ newValue: Int) {
        value = newValue
        UserDefaults.standard.set(newValue, forKey: userDefaultsKey)
        NotificationCenter.default.post(name: notificationName, object: nil)
    }
}
