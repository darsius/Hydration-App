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
    @Binding var currentAmount: Int
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
                    
                    let convertedDailyGoal = viewModel.convertedAmount(amount: dailyGoal, from: oldValue, to: newValue)
                    viewModel.saveConvertedAmount(convertedDailyGoal, for: UserDefaultsKeys.dailyGoal, newUnit: newValue)
                    dailyGoal = convertedDailyGoal
                    
                    let convertedCurrentAmount = viewModel.convertedAmount(amount: currentAmount, from: oldValue, to: newValue)
                    viewModel.saveConvertedAmount(convertedCurrentAmount, for: UserDefaultsKeys.currentAmount, newUnit: newValue)
                    currentAmount = convertedCurrentAmount
                    
                    let convertedContainer1 = viewModel.convertedAmount(amount: container1, from: oldValue, to: newValue)
                    viewModel.saveConvertedAmount(convertedContainer1, for: UserDefaultsKeys.container1, newUnit: newValue)
                    container1 = convertedContainer1
                    
                    let convertedContainer2 = viewModel.convertedAmount(amount: container2, from: oldValue, to: newValue)
                    viewModel.saveConvertedAmount(convertedContainer2, for: UserDefaultsKeys.container2, newUnit: newValue)
                    container2 = convertedContainer2
                    
                    let convertedContainer3 = viewModel.convertedAmount(amount: container3, from: oldValue, to: newValue)
                    viewModel.saveConvertedAmount(convertedContainer3, for: UserDefaultsKeys.container3, newUnit: newValue)
                    container3 = convertedContainer3
                    
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
