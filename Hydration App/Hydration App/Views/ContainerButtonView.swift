//
//  ContainerButtonView.swift
//  Hydration App
//
//  Created by Paraschiv, Darius on 23.07.2025.
//

import SwiftUI

struct ContainerButtonView: View {
    let label: String
    var body: some View {
        Button(action: {
            print("tapped \(label)")
        }) {
            Text(label)
                .padding(.vertical, 8)
                .padding(.horizontal, 26)
                .font(.regularText)
                .background(.GREEN)
                .foregroundStyle(.black)
                .cornerRadius(4)
        }
    }
}

#Preview {
    ContainerButtonView(label: "350 ml")
}
