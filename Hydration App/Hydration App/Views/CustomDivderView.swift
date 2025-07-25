//
//  CustomDivderView.swift
//  Hydration App
//
//  Created by Paraschiv, Darius on 25.07.2025.
//

import SwiftUI

struct CustomDivderView: View {
    var body: some View {
        VStack {
            Divider()
                .frame(height: TodayConstants.dividerHeight)
                .background(.GREEN)
            Spacer()
        }
    }
}

#Preview {
    CustomDivderView()
}
