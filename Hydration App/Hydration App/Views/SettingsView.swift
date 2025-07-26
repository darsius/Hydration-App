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
            VStack {
                CustomDivderView()
                List {
                    Section("") {
                        NavigationLink(destination: UnitsView()){
                            HStack {
                                Text("Units")
                                    .font(.listText)
                                Spacer()
                                Text("ml")
                                    .font(.listText)
                            }
                        }
                        
                        NavigationLink(destination: DailyGoalView()){
                            HStack {
                                Text("Daily Goal")
                                    .font(.listText)
                                Spacer()
                                Text("2.000 ml")
                                    .font(.listText)
                            }
                        }
                    }
                    .alignmentGuide(.listRowSeparatorLeading) { _ in
                        return SettingsConstants.listRowDividerLeadingSpacing
                        
                    }
                    .listRowBackground(Color(.GRAY_1))
                    .listRowSeparatorTint(Color(.WHITE))
                    .listSectionSpacing(SettingsConstants.listSectionSpacing)
                    
                    Section {
                        NavigationLink(destination: ContainerView()) {
                            HStack {
                                Text("Container 1")
                                    .font(.listText)
                                Spacer()
                                Text("200 ml")
                                    .font(.listText)
                            }
                        }
                        .listRowBackground(Color(.GRAY_1))
                        
                        NavigationLink(destination: ContainerView()) {
                            HStack {
                                Text("Container 2")
                                Spacer()
                                Text("400 ml")
                            }
                        }
                        
                        .listRowBackground(Color(.GRAY_1))
                        .font(.listText)
                        
                        NavigationLink(destination: ContainerView()) {
                            HStack {
                                Text("Container 3")
                                Spacer()
                                Text("500 ml")
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
                        return SettingsConstants.listRowDividerLeadingSpacing
                        
                    }
                    .listRowSeparatorTint(Color(.WHITE))
                }
                
                .navigationBarBackButtonHidden(true)
                .listStyle(.inset)
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
}

#Preview {
    SettingsView()
}
