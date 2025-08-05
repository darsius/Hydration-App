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
    var context: ModelContext?
    
    private init() {
        do {
            container = try ModelContainer(for: ChartDay.self)
            if let container {
                context = ModelContext(container)
            }
        } catch {
            debugPrint("Error initializing database container:", error)
        }
    }
}
