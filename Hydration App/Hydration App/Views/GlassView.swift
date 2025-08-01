//
//  GlassView.swift
//  Hydration App
//
//  Created by Paraschiv, Darius on 01.08.2025.
//

import SwiftUI

struct GlassView: View {
    let dailyGoal: Int
    let currentAmount: Int
    
    var fillRatio: CGFloat {
        min(CGFloat(currentAmount) / CGFloat(dailyGoal), 1.0)
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Image("Glass_empty")
            Image("Glass_filled")
                .mask {
                    GeometryReader { geometry in
                        Rectangle()
                            .frame(height: geometry.size.height * fillRatio)
                            .offset(y: geometry.size.height * (1 - fillRatio))
                            .animation(.easeInOut(duration: 0.3), value: fillRatio)
                    }
                }
        }
    }
}
