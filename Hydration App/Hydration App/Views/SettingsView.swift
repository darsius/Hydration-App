//
//  SettingsView.swift
//  Hydration App
//
//  Created by Paraschiv, Darius on 25.07.2025.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack {
            VStack {
                CustomDivderView()
                List {
                    Section("") {
                        NavigationLink(destination: UnitsView()) {
                            SettingsRowView(title: "Units", value: "ml")
                        }
                        
                        NavigationLink(destination: DailyGoalView()) {
                            SettingsRowView(title: "Daily Goal", value: "2.000 ml")
                        }
                    }
                    .alignmentGuide(.listRowSeparatorLeading) { _ in
                        ListRowConstants.separatorLeadingOffset
                    }
                    .listRowBackground(Color(.GRAY_1))
                    .listRowSeparatorTint(Color(.WHITE))
                    .listSectionSpacing(SettingsConstants.listSectionSpacing)
                    
                    Section {
                        NavigationLink(destination: ContainerView()) {
                            SettingsRowView(title: "Container 1", value: "200 ml")
                        }
                        .listRowBackground(Color(.GRAY_1))
                        
                        NavigationLink(destination: ContainerView()) {
                            SettingsRowView(title: "Container 2", value: "400 ml")
                        }
                        .listRowBackground(Color(.GRAY_1))
                        
                        NavigationLink(destination: ContainerView()) {
                            SettingsRowView(title: "Container 3", value: "500 ml")
                        }
                        .listRowBackground(Color(.GRAY_1))
                        
                    } header: {
                        Text("Containers")
                    } footer: {
                        Text("These containers will appear on your main screen so you can easily tap on them and track your intake.")
                    }
                    .alignmentGuide(.listRowSeparatorLeading) { _ in
                        ListRowConstants.separatorLeadingOffset
                    }
                    .listRowSeparatorTint(Color(.WHITE))
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

#Preview {
    SettingsView()
}
