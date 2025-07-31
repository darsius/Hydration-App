//
//  HydrationInput-ViewModel.swift
//  Hydration App
//
//  Created by Paraschiv, Darius on 29.07.2025.
//

import Foundation

@Observable
class HydrationInputViewModel {
    let viewType: HydrationViewType
    private let storageKey: String
    
    weak var todayViewModel: TodayViewModel?

//    var amount: Int {
//        didSet {
//            saveToUserDefaults()
//        }
//    }

    init(type: HydrationViewType) {
        self.viewType = type
        self.storageKey = type.id
//        self.amount = Self.loadFromUserDefaults(key: storageKey) ?? type.defaultAmount
    }

    var informationalDescription: String {
        viewType.informationalDescription
    }

//    private func saveToUserDefaults() {
//        UserDefaults.standard.set(amount, forKey: storageKey)
//    }

    private static func loadFromUserDefaults(key: String) -> Int? {
        UserDefaults.standard.value(forKey: key) as? Int
    }

//    func save() {
//        saveToUserDefaults()
//        print("Saved amount: \(amount) for \(viewType.id)")
//    }
}
