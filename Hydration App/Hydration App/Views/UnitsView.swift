//
//  UnitsView.swift
//  Hydration App
//
//  Created by Paraschiv, Darius on 25.07.2025.
//

import SwiftUI

struct UnitsView: View {
    @Environment(\.dismiss) private var dismiss
    var viewModel: UnitsViewModel
    
    @Binding var selectedUnit: String
    
    var body: some View {
        VStack {
            CustomDividerView()
            List {
                Section("") {
                    ForEach(UnitType.allCases, id: \.self) { unit in
                        HStack {
                            Text(unit.label)
                            Spacer()
                            Image(.checkmarkGoal)
                                .opacity(selectedUnit == unit.rawValue ? 1 : 0)
                        }
                        .font(.regularText)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            selectedUnit = unit.rawValue
                            viewModel.notifyUnitChanged()
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
