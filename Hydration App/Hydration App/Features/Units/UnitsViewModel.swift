//
//  UnitsViewModel.swift
//  Hydration App
//
//  Created by Paraschiv, Darius on 12.08.2025.
//

import Foundation

class UnitsViewModel: ObservableObject {
    @Published var selectedUnit: UnitType {
        didSet {
            UserDefaults.standard.set(selectedUnit.rawValue, forKey: UserDefaultsKeys.unit)
            NotificationCenter.default.post(name: .unitDidChange, object: nil)
        }
    }
    
    init(selectedUnit: UnitType) {
        self.selectedUnit = selectedUnit
    }
}
