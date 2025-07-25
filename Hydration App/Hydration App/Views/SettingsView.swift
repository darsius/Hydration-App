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
        let plainSpace = "    "
        NavigationStack {
            CustomDivderView()
            List {
                Section("") {
                    HStack {
                        Text(plainSpace + "Units")
                            .font(.listText)
                        Spacer()
                        Text("ml" + plainSpace)
                            .font(.listText)
                    }
                    .listRowInsets(EdgeInsets())
                    
                    HStack {
                        Text(plainSpace + "Daily Goal")
                            .font(.listText)
                        Spacer()
                        Text("2.000 ml" + plainSpace)
                            .font(.listText)
                    }
                    .listRowInsets(EdgeInsets())
                }
                .listRowBackground(Color(.GRAY_1))
                .listRowSeparatorTint(Color(.WHITE))
                
                Section(header: Text("Containers")) {
                    HStack {
                        Text(plainSpace + "Container 1")
                            .font(.listText)
                        Spacer()
                        Text("200 ml" + plainSpace)
                            .font(.listText)
                    }
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(Color(.GRAY_1))
                    
                    HStack {
                        Text(plainSpace + "Container 2")
                        Spacer()
                        Text("400 ml" + plainSpace)
                    }
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(Color(.GRAY_1))
                    .font(.listText)
                    
                    HStack {
                        Text(plainSpace + "Container 3")
                        Spacer()
                        Text("500 ml" + plainSpace)
                    }
                    .font(.listText)
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(Color(.GRAY_1))
                    
                    Text("These containers will appear on your main screen so you can easily tap on them and track your intake.")
                        .multilineTextAlignment(.leading)
                        .listRowSeparator(.hidden)
                        .padding(.horizontal, -10)
                        .font(.listText)
                }
                .listRowSeparatorTint(Color(.WHITE))
            }
            .navigationBarBackButtonHidden(true)
            .listStyle(.plain)
            .navigationBarTitle("Settings", displayMode: .inline)
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
