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

    init(type: HydrationViewType) {
        self.viewType = type
        self.storageKey = type.id
    }

    var informationalDescription: String {
        viewType.informationalDescription
    }
}
