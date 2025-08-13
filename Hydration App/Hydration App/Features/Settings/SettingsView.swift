//
//  SettingsView.swift
//  Hydration App
//
//  Created by Paraschiv, Darius on 25.07.2025.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    
    @StateObject var viewModel: SettingsViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                CustomDividerView()
                List {
                    Section("") {
                        NavigationLink(destination: UnitsView(viewModel: UnitsViewModel(selectedUnit: viewModel.unit))) {
                                SettingsRowView(title: "Units", value: viewModel.unit.rawValue)
                        }
                        
                        NavigationLink(destination: HydrationInputView(
                            viewModel: HydrationInputViewModel(
                                initialValue: viewModel.dailyGoal,
                                inputType: .dailyGoal,
                                unit: viewModel.unit),
                            viewType: .dailyGoal)) {
                                SettingsRowView(title: "Daily Goal", value: "\(viewModel.dailyGoal) \(viewModel.unit)")
                        }
                    }
                    .alignmentGuide(.listRowSeparatorLeading) { _ in
                        UIConstants.separatorLeadingOffset
                    }
                    .listRowBackground(Color(UIColor.systemGray3))
                    .listRowSeparatorTint(.white)
                    .listSectionSpacing(UIConstants.listSectionSpacing)
                    
                    Section {
                        NavigationLink(destination: HydrationInputView(
                            viewModel: HydrationInputViewModel(
                                initialValue: viewModel.container1,
                                inputType: .container(1),
                                unit: viewModel.unit),
                            viewType: .container(1))) {
                                SettingsRowView(title: "Container 1", value: "\(viewModel.container1) \(viewModel.unit)")
                        }
                        .listRowBackground(Color(UIColor.systemGray3))
                        
                        NavigationLink(destination: HydrationInputView(
                            viewModel: HydrationInputViewModel(
                                initialValue: viewModel.container2,
                                inputType: .container(2),
                                unit: viewModel.unit),
                            viewType: .container(2))) {
                                SettingsRowView(title: "Container 2", value: "\(viewModel.container2) \(viewModel.unit)")
                        }
                        .listRowBackground(Color(UIColor.systemGray3))
                        
                        NavigationLink(destination: HydrationInputView(
                            viewModel: HydrationInputViewModel(
                                initialValue: viewModel.container3,
                                inputType: .container(3),
                                unit: viewModel.unit),
                            viewType: .container(3))) {
                                SettingsRowView(title: "Container 3", value: "\(viewModel.container3) \(viewModel.unit)")
                        }
                        .listRowBackground(Color(UIColor.systemGray3))
                        
                    }
                    header: {
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
