//
//  UnitsView.swift
//  Hydration App
//
//  Created by Paraschiv, Darius on 25.07.2025.
//

import SwiftUI

struct UnitsView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            CustomDivderView()
            List {
                Section("") {
                    HStack {
                        Text("mililiters (ml)")
                    }
                    HStack {
                        Text("ounces (oz)")
                    }
                }
                .listRowSeparatorTint(Color(.WHITE))
                .listRowBackground(Color(.GRAY_1))
                .alignmentGuide(.listRowSeparatorLeading) { _ in
                    return -20
                }
            }
            .listStyle(.inset)
            .navigationBarTitle("Units", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
            .toolbar{
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(.back)
                    }
                }
                
            }
        }
    }
}

#Preview {
    UnitsView()
}
