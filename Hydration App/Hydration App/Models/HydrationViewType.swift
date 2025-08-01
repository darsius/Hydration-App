//
//  HydrationViewType.swift
//  Hydration App
//
//  Created by Paraschiv, Darius on 28.07.2025.
//

import Foundation

enum HydrationViewType: Identifiable, Equatable {
    case dailyGoal
    case container(Int)

    var id: String {
        switch self {
        case .dailyGoal: return "dailyGoal"
        case .container(let index): return "container\(index)"
        }
    }

    var navbarTitle: String {
        switch self {
        case .dailyGoal: return "Daily Goal"
        case .container(let i): return "Container \(i)"
        }
    }

    var informationalDescription: String {
        switch self {
        case .dailyGoal:
            return "Here you can set your hydration goal based on your preferred unit of measurement"
        case .container:
            return "Here you can specify your container size so it would be easier to enter your daily liquied intake"
        }
    }

    var defaultAmount: Int {
        switch self {
        case .dailyGoal:
            return 2000
        case .container(let index):
            switch index {
            case 1: return 200
            case 2: return 400
            case 3: return 500
            default: return 100
            }
        }
    }
}
