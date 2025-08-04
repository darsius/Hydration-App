//
//  SettingsView.swift
//  Hydration App
//
//  Created by Paraschiv, Darius on 25.07.2025.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State var viewModel: SettingsViewModel
    
    @Binding var dailyGoal: Int
    @Binding var container1: Int
    @Binding var container2: Int
    @Binding var container3: Int
    @Binding var unit: String
    
    var body: some View {
        NavigationStack {
            VStack {
                CustomDividerView()
                List {
                    Section("") {
                        NavigationLink(destination: UnitsView(viewModel: UnitsViewModel(unitType: UnitType.ml.rawValue), selectedUnit: $unit)){
                            SettingsRowView(title: "Units", value: unit)
                        }
                        
                        NavigationLink(destination: HydrationInputView(viewModel: HydrationInputViewModel(type: .dailyGoal), inputValue: $dailyGoal)) {
                            SettingsRowView(title: "Daily Goal", value: "\(dailyGoal) \(unit)")
                        }
                    }
                    .alignmentGuide(.listRowSeparatorLeading) { _ in
                        UIConstants.separatorLeadingOffset
                    }
                    .listRowBackground(Color.lightGray)
                    .listRowSeparatorTint(.white)
                    .listSectionSpacing(UIConstants.listSectionSpacing)
                    
                    Section {
                        NavigationLink(destination: HydrationInputView(viewModel: HydrationInputViewModel(type: .container(1)), inputValue: $container1)) {
                            SettingsRowView(title: "Container 1", value: "\(container1) \(unit)")
                            
                        }
                        .listRowBackground(Color.lightGray)
                        
                        NavigationLink(destination: HydrationInputView(viewModel: HydrationInputViewModel(type: .container(2)), inputValue: $container2)) {
                            SettingsRowView(title: "Container 2", value: "\(container2) \(unit)")
                        }
                        .listRowBackground(Color.lightGray)
                        
                        NavigationLink(destination: HydrationInputView(viewModel: HydrationInputViewModel(type: .container(3)), inputValue: $container3)) {
                            SettingsRowView(title: "Container 3", value: "\(container3) \(unit)")
                        }
                        .listRowBackground(Color.lightGray)
                        
                    } header: {
                        Text("Containers")
                    } footer: {
                        Text("These containers will appear on your main screen so you can easily tap on them and track your intake.")
                    }
                    .alignmentGuide(.listRowSeparatorLeading) { _ in
                        UIConstants.separatorLeadingOffset
                    }
                    .listRowSeparatorTint(.white)
                }
                .toolbarRole(.editor)
                .listStyle(.inset)
                .navigationBarTitle("Settings", displayMode: .inline)
                
                .onChange(of: unit) { oldValue, newValue in
                    viewModel.convertAll(
                        dailyGoal: &dailyGoal,
                        container1: &container1,
                        container2: &container2,
                        container3: &container3,
                        from: oldValue,
                        to: newValue)
                }
            }
        }
    }
}

struct SettingsRowView: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Text(value)
        }
        .font(.regularText)
    }
}
