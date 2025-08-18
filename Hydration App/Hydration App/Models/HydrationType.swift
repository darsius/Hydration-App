//
//  HydrationType.swift
//  Hydration App
//
//  Created by Paraschiv, Darius on 13.08.2025.
//

import Foundation

enum HydrationType {
    case dailyGoal
    case container(Int)
    
    var userDefaultsKey: String {
        switch self {
        case .dailyGoal:
            UserDefaultsKeys.dailyGoal
        case .container(let index):
            switch index {
            case 1: UserDefaultsKeys.container1
            case 2: UserDefaultsKeys.container2
            case 3: UserDefaultsKeys.container3
            default: fatalError("Invalid container index")
            }
        }
    }
    
    var notificationName: Notification.Name {
        switch self {
        case .dailyGoal:
            .dailyGoalDidChange
        case .container(let index):
            switch index {
            case 1: .container1DidChange
            case 2: .container2DidChange
            case 3: .container3DidChange
            default: fatalError("Invalid container index")
            }
        }
    }
}

extension HydrationType {
    var hydrationViewType: HydrationViewType {
        switch self {
        case .dailyGoal:
            .dailyGoal
        case .container(let index):
            .container(index)
        }
    }
}
