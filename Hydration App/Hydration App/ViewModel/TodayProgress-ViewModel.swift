//
//  HydrationViewModel.swift
//  Hydration App
//
//  Created by Paraschiv, Darius on 28.07.2025.
//

import Foundation

@Observable
class HydrationViewModel {
    var type: HydrationViewType
    var amount: Int
    
    init(type: HydrationViewType) {
        self.type = type
        self.amount = type.defaultAmount
    }
}
