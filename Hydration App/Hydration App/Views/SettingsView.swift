//
//  SettingsView.swift
//  Hydration App
//
//  Created by Paraschiv, Darius on 25.07.2025.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            List {
                Section("") {
                    HStack {
                        Text("Units")
                        Spacer()
                        Text("ml")
                    }
                    
                    HStack {
                        Text("Daily Goal")
                        Spacer()
                        Text("2.000 ml")
                    }
                }
                .listRowBackground(Color(.GRAY_1))
                .listRowSeparatorTint(Color(.YELLOW))
                
                Section(header: Text("Containers")) {
                    HStack {
                        Text("Container 1")
                        Spacer()
                        Text("200 ml")
                    }
                    .listRowBackground(Color(.GRAY_1))
                    
                    HStack {
                        Text("Container 2")
                        Spacer()
                        Text("400 ml")
                    }
                    .listRowBackground(Color(.GRAY_1))
                    
                    HStack {
                        Text("Container 3")
                        Spacer()
                        Text("500 ml")
                    }
                    .listRowBackground(Color(.GRAY_1))
                    
                    Text("These containers will appear on your main screen so you can easily tap on them and track your intake.")
                        .listRowSeparator(.hidden)
                }
                .listRowSeparatorTint(Color(.YELLOW))
                
            }
            .listStyle(.plain)
            .navigationBarTitle("Settings", displayMode: .inline)
            .navigationBarBackButtonHidden()
            .toolbar{
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(.back)
                    }
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}
