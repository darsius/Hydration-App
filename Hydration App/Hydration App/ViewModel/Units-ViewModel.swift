//
//  Units-ViewModel.swift
//  Hydration App
//
//  Created by Paraschiv, Darius on 31.07.2025.
//

import Foundation

@Observable
class UnitsViewModel {
    var unitType: String
    private var unitConverter = 29.5735
    
    init(unitType: String) {
        self.unitType = unitType
    }
    
    func notifyUnitChanged() {
        NotificationCenter.default.post(name: .unitChanged, object: nil)
    }
}

extension Notification.Name {
    static let unitChanged = Notification.Name("unitChanged")
}
