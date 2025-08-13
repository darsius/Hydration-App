//
//  UnitsView.swift
//  Hydration App
//
//  Created by Paraschiv, Darius on 25.07.2025.
//

import SwiftUI

struct UnitsView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: UnitsViewModel
    
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
                                .opacity(viewModel.selectedUnit == unit ? 1 : 0)
                        }
                        .font(.regularText)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            viewModel.selectedUnit = unit
                        }
                    }
                }
                .listRowSeparatorTint(.white)
                .listRowBackground(Color(UIColor.systemGray3))
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
