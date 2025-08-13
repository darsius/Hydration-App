//
//  HydrationInputViewModel.swift
//  Hydration App
//
//  Created by Paraschiv, Darius on 11.08.2025.
//

import Foundation

class HydrationInputViewModel: ObservableObject {
    private let inputType: HydrationType
    
    @Published var initialValue: Int
    @Published var unit: UnitType
    
    init(initialValue: Int, inputType: HydrationType, unit: UnitType) {
        self.initialValue = initialValue
        self.inputType = inputType
        self.unit = unit
    }
    
    func saveValue(_ newValue: Int) {
        initialValue = newValue
        UserDefaults.standard.set(newValue, forKey: inputType.userDefaultsKey)
        NotificationCenter.default.post(name: inputType.notificationName, object: nil)
    }
}
