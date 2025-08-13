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
            return UserDefaultsKeys.dailyGoal
        case .container(let index):
            switch index {
            case 1:
                return UserDefaultsKeys.container1
            case 2:
                return UserDefaultsKeys.container2
            case 3:
                return UserDefaultsKeys.container3
            default: fatalError("Invalid container index")
            }
        }
    }
    
    var notificationName: Notification.Name {
        switch self {
        case .dailyGoal:
            return .dailyGoalDidChange
        case .container(let index):
            switch index {
            case 1:
                return .container1DidChange
            case 2:
                return .container2DidChange
            case 3:
                return .container3DidChange
            default: fatalError("Invalid container index")
            }
        }
    }
}
