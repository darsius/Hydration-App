//
//  CustomDivderView.swift
//  Hydration App
//
//  Created by Paraschiv, Darius on 25.07.2025.
//

import SwiftUI

struct CustomDivderView: View {
    var body: some View {
        Image(.topbarLine)
            .resizable()
            .scaledToFit()
            .frame(maxWidth: .infinity)
            .clipped()
    }
}

#Preview {
    CustomDivderView()
}
