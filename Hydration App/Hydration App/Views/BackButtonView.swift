//
//  BackButtonView.swift
//  Hydration App
//
//  Created by Paraschiv, Darius on 28.07.2025.
//

import SwiftUI

struct BackButtonView: ToolbarContent {
    let dismiss: DismissAction
    
    var body: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Button(action: {
                dismiss()
            }) {
                Image(.back)
            }
        }
    }
}
