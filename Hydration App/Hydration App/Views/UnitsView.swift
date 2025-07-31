//
//  UnitsView.swift
//  Hydration App
//
//  Created by Paraschiv, Darius on 25.07.2025.
//

import SwiftUI

struct UnitsView: View {
    @State private var selectedUnit: UnitType = .ml
    
    var body: some View {
        VStack {
            CustomDivderView()
            List {
                Section("") {
                    ForEach(UnitType.allCases, id: \.self) { unit in
                        HStack {
                            Text(unit.label)
                            Spacer()
                            Image(.checkmarkGoal)
                                .opacity(selectedUnit == unit ? 1 : 0)
                        }
                        .font(.regularText)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            selectedUnit = unit
                        }
                    }
                }
                .listRowSeparatorTint(.white)
                .listRowBackground(Color.lightGray)
                .alignmentGuide(.listRowSeparatorLeading) { _ in
                    UIConstants.separatorLeadingOffset
                }
            }
            .toolbarRole(.editor)
            .listStyle(.inset)
            .navigationBarTitle("Units", displayMode: .inline)
        }
    }
}

#Preview {
    UnitsView()
}
