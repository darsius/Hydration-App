//
//  CustomDividerView.swift
//  Hydration App
//
//  Created by Paraschiv, Darius on 28.07.2025.
//

import SwiftUI

struct CustomDividerView: View {
    var body: some View {
        Image(.topbarLine)
            .resizable()
            .scaledToFit()
            .frame(maxWidth: .infinity)
            .clipped()
    }
}

#Preview {
    CustomDividerView()
}
