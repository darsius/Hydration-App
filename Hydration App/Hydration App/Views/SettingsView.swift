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
                CustomDivderView()
                List {
                    Section("") {
                        NavigationLink(destination: UnitsView(viewModel: UnitsViewModel(unitType: UnitType.ml.rawValue), selectedUnit: $unit)){
                            HStack {
                                Text("Units")
                                    .font(.listText)
                                Spacer()
                                Text(unit)
                                    .font(.listText)
                            }
                        }
                        
                        NavigationLink(destination: HydrationInputView(viewModel: HydrationInputViewModel(type: .dailyGoal), inputValue: $dailyGoal)) {
                            HStack {
                                Text("Daily Goal")
                                    .font(.listText)
                                Spacer()
                                Text("\(dailyGoal) \(unit)")
                                    .font(.listText)
                            }
                        }
                    }
                    .alignmentGuide(.listRowSeparatorLeading) { _ in
                        return ListRowConstants.separatorLeadingOffset
                        
                    }
                    .listRowBackground(Color(.GRAY_1))
                    .listRowSeparatorTint(Color(.WHITE))
                    .listSectionSpacing(SettingsConstants.listSectionSpacing)
                    
                    Section {
                        NavigationLink(destination: HydrationInputView(viewModel: HydrationInputViewModel(type: .container(1)), inputValue: $container1)) {
                            HStack {
                                Text("Container 1")
                                    .font(.listText)
                                Spacer()
                                Text("\(container1) \(unit)")
                                    .font(.listText)
                            }
                        }
                        .listRowBackground(Color(.GRAY_1))
                        
                        NavigationLink(destination: HydrationInputView(viewModel: HydrationInputViewModel(type: .container(2)), inputValue: $container2)) {
                            HStack {
                                Text("Container 2")
                                Spacer()
                                Text("\(container2) \(unit)")
                            }
                        }
                        .font(.listText)
                        .listRowBackground(Color(.GRAY_1))
                        
                        NavigationLink(destination: HydrationInputView(viewModel: HydrationInputViewModel(type: .container(3)), inputValue: $container3)) {
                            HStack {
                                Text("Container 3")
                                Spacer()
                                Text("\(container3) \(unit)")
                            }
                        }
                        .font(.listText)
                        .listRowBackground(Color(.GRAY_1))
                        
                    } header: {
                        Text("Containers")
                    } footer: {
                        Text("These containers will appear on your main screen so you can easily tap on them and track your intake.")
                    }
                    .alignmentGuide(.listRowSeparatorLeading) { _ in
                        return ListRowConstants.separatorLeadingOffset
                        
                    }
                    .listRowSeparatorTint(Color(.WHITE))
                }
                
                .navigationBarBackButtonHidden(true)
                .listStyle(.inset)
                .navigationBarTitle("Settings", displayMode: .inline)
                .toolbar{
                    BackButtonView(dismiss: dismiss)
                }

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
