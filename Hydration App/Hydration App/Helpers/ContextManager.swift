//
//  ContextManager.swift
//  Hydration App
//
//  Created by Paraschiv, Darius on 05.08.2025.
//

import Foundation
import SwiftData

class ContextManager {
    static let shared = ContextManager()
    
    var container: ModelContainer?
    
    private init() {
        do {
            container = try ModelContainer(for: HydrationDay.self)
        } catch {
            debugPrint("Error initializing database container:", error)
        }
    }
}
