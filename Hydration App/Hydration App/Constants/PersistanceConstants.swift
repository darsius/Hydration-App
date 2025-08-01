//
//  Constants.swift
//  Hydration App
//
//  Created by Paraschiv, Darius on 01.08.2025.
//

import Foundation

enum UserDefaultsKeys: CaseIterable {
    static let dailyGoal = "dailyGoal"
    static let currentAmount = "currentAmount"
    static let container1 = "container1"
    static let container2 = "container2"
    static let container3 = "container3"
    static let unit = "unit"
}

enum Defaults {
    static let dailyGoal = 2000
    static let currentAmount = 0
    static let container1 = 100
    static let container2 = 200
    static let container3 = 400
    static let unit = "ml"
}
