//
//  UnitType.swift
//  Hydration App
//
//  Created by Paraschiv, Darius on 27.07.2025.
//

import Foundation

enum UnitType: CaseIterable {
    case ml
    case oz
    
    var label: String {
        switch self {
        case .ml: return "mililiters (ml)"
        case .oz: return "ounces (oz)"
        }
    }
}
