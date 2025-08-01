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
            CustomDivderView()
            List {
                Section("") {
                    ForEach(UnitType.allCases, id: \.self) { unit in
                        HStack {
                            Text(unit.label)
                            Spacer()
                            if selectedUnit == unit.rawValue {
                                Image(.checkmarkGoal)
                            }
                        }
                        .font(.listText)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            selectedUnit = unit.rawValue
                            viewModel.notifyUnitChanged()
                        }
                    }
                }
                .listRowSeparatorTint(Color(.WHITE))
                .listRowBackground(Color(.GRAY_1))
                .alignmentGuide(.listRowSeparatorLeading) { _ in
                    return ListRowConstants.separatorLeadingOffset
                }
            }
            .listStyle(.inset)
            .navigationBarTitle("Units", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
            .toolbar{
                BackButtonView(dismiss: dismiss)
            }
        }
    }
}
