//
//  UnitsView.swift
//  Hydration App
//
//  Created by Paraschiv, Darius on 25.07.2025.
//

import SwiftUI

struct UnitsView: View {
    @Environment(\.dismiss) private var dismiss
    
    @Binding var selectedUnit: UnitType
    
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
                                .opacity(selectedUnit == unit ? 1 : 0)
                        }
                        .font(.regularText)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            selectedUnit = unit
                            UserDefaults.standard.set(unit.rawValue, forKey: UserDefaultsKeys.unit) //
                            NotificationCenter.default.post(name: .unitDidChange, object: nil) //
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
