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
    var coordinator: AppCoordinator
    
    var body: some View {
        NavigationStack {
            VStack {
                CustomDividerView()
                List {
                    Section("") {
                        NavigationLink(destination: coordinator.makeUnitsView(unit: viewModel.unit)) {
                                SettingsRowView(title: "Units", value: viewModel.unit.rawValue)
                        }
                        
                        NavigationLink(destination: coordinator.makeInputView(
                            initialValue: viewModel.dailyGoal,
                            inputType: .dailyGoal,
                            unit: viewModel.unit)) {
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
                        NavigationLink(destination: coordinator.makeInputView(
                            initialValue: viewModel.container1,
                            inputType: .container(1),
                            unit: viewModel.unit)) {
                                SettingsRowView(title: "Container 1", value: "\(viewModel.container1) \(viewModel.unit)")
                        }
                        .listRowBackground(Color(UIColor.systemGray3))
                        
                        NavigationLink(destination: coordinator.makeInputView(
                            initialValue: viewModel.container2,
                            inputType: .container(2),
                            unit: viewModel.unit)) {
                                SettingsRowView(title: "Container 2", value: "\(viewModel.container2) \(viewModel.unit)")
                        }
                        .listRowBackground(Color(UIColor.systemGray3))
                        
                        NavigationLink(destination: coordinator.makeInputView(
                            initialValue: viewModel.container3,
                            inputType: .container(3),
                            unit: viewModel.unit)) {
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
