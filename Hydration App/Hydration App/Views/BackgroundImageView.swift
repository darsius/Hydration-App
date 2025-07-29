//
//  BackgroundImageView.swift
//  Hydration App
//
//  Created by Paraschiv, Darius on 28.07.2025.
//

import SwiftUI

struct BackgroundImageView: View {
    var body: some View {
        Image(.leafBackground)
            .resizable()
            .scaledToFill()
            .blur(radius: 0.7)
    }
}

#Preview {
    BackgroundImageView()
}
