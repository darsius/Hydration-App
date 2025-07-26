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
                            .padding(.trailing, 10)
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
                    .alignmentGuide(.listRowSeparatorLeading) { viewDimensions in
                        return viewDimensions[.listRowSeparatorLeading] - 20
                        
                    }
                    .listRowBackground(Color(.GRAY_1))
                    .listRowSeparatorTint(Color(.WHITE))
                    .listSectionSpacing(SettingsConstants.listSectionSpacing)
                    
                    Section {
                        HStack {
                            Text("Container 1")
                                .font(.listText)
                            Spacer()
                            Text("200 ml")
                                .font(.listText)
                        }
                        .listRowBackground(Color(.GRAY_1))
                        
                        HStack {
                            Text("Container 2")
                            Spacer()
                            Text("400 ml")
                        }
                        .listRowBackground(Color(.GRAY_1))
                        .font(.listText)
                        
                        HStack {
                            Text("Container 3")
                            Spacer()
                            Text("500 ml")
                        }
                        .font(.listText)
                        .listRowBackground(Color(.GRAY_1))
                        
                    } header: {
                        Text("Containers")
                    } footer: {
                        Text("These containers will appear on your main screen so you can easily tap on them and track your intake.")
                    }
                    .alignmentGuide(.listRowSeparatorLeading) { viewDimensions in
                        return viewDimensions[.listRowSeparatorLeading] - 20
                        
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
