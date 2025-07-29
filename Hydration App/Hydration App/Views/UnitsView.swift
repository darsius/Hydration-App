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
                            if selectedUnit == unit {
                                Image(.checkmarkGoal)
                            }
                        }
                        .font(.regularText)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            selectedUnit = unit
                        }
                    }
                }
                .listRowSeparatorTint(Color(.WHITE))
                .listRowBackground(Color(.GRAY_1))
                .alignmentGuide(.listRowSeparatorLeading) { _ in
                    ListRowConstants.separatorLeadingOffset
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
