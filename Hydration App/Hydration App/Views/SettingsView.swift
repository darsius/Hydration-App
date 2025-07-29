//
//  SettingsView.swift
//  Hydration App
//
//  Created by Paraschiv, Darius on 25.07.2025.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var viewModel: SettingsViewModel
    
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
                        
                        NavigationLink(destination: HydrationInputView(viewModel: viewModel.dailyGoal)) {
                            HStack {
                                Text("Daily Goal")
                                    .font(.listText)
                                Spacer()
                                Text("\(viewModel.dailyGoal.amount) ml")
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
                        NavigationLink(destination: HydrationInputView(viewModel: viewModel.container1)) {
                            HStack {
                                Text("Container 1")
                                    .font(.listText)
                                Spacer()
                                Text("\(viewModel.container1.amount) ml")
                                    .font(.listText)
                            }
                        }
                        .listRowBackground(Color(.GRAY_1))
                        
                        NavigationLink(destination: HydrationInputView(viewModel: viewModel.container2)) {
                            HStack {
                                Text("Container 2")
                                Spacer()
                                Text("\(viewModel.container2.amount) ml")
                            }
                        }
                        .font(.listText)
                        .listRowBackground(Color(.GRAY_1))
                        
                        NavigationLink(destination: HydrationInputView(viewModel: viewModel.container3)) {
                            HStack {
                                Text("Container 3")
                                Spacer()
                                Text("\(viewModel.container3.amount) ml")
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
            }
        }
    }
}

//#Preview {
//    SettingsView()
//}
