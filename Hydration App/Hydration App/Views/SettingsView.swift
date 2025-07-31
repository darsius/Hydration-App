//
//  SettingsView.swift
//  Hydration App
//
//  Created by Paraschiv, Darius on 25.07.2025.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    
    @Binding var dailyGoal: Int
    @Binding var container1: Int
    @Binding var container2: Int
    @Binding var container3: Int
    
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
                        
                        NavigationLink(destination: HydrationInputView(viewModel: HydrationInputViewModel(type: .dailyGoal), inputValue: $dailyGoal)) {
                            HStack {
                                Text("Daily Goal")
                                    .font(.listText)
                                Spacer()
                                Text("\(dailyGoal) ml")
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
                                Text("\(container1) ml")
                                    .font(.listText)
                            }
                        }
                        .listRowBackground(Color(.GRAY_1))
                        
                        NavigationLink(destination: HydrationInputView(viewModel: HydrationInputViewModel(type: .container(2)), inputValue: $container2)) {
                            HStack {
                                Text("Container 2")
                                Spacer()
                                Text("\(container2) ml")
                            }
                        }
                        .font(.listText)
                        .listRowBackground(Color(.GRAY_1))
                        
                        NavigationLink(destination: HydrationInputView(viewModel: HydrationInputViewModel(type: .container(3)), inputValue: $container3)) {
                            HStack {
                                Text("Container 3")
                                Spacer()
                                Text("\(container3) ml")
                            }
                        }
                        .font(.listText)
                        .listRowBackground(Color(.GRAY_1))
                        
                    }
                        header: {
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
            }
        }
    }
}
//
//#Preview {
//    SettingsView(dailyGoal: $dail)
//}
