//
//  HydrationInputView.swift
//  Hydration App
//
//  Created by Paraschiv, Darius on 28.07.2025.
//

import SwiftUI

struct HydrationInputView: View {
    @Environment(\.dismiss) private var dismiss
    @FocusState private var focus: Bool
    @Bindable var viewModel: HydrationViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            CustomDivderView()
            ZStack {
                BackgroundImageView()
                VStack(spacing: 100) {
                    Text(viewModel.type.informationalDescription)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                    
                    VStack {
                        TextField("", value: $viewModel.amount, formatter: NumberFormatter())
                            .multilineTextAlignment(.center)
                            .keyboardType(.numberPad)
                            .focused($focus)
                            .font(.dailyGoal)
                            .frame(width: 120, height: 70)
                            .overlay {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.GREEN, lineWidth: 3)
                            }
                        Text("mililiters (ml)")
                            .font(.title)
                    }
                    .onAppear {
                        focus = true
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("Daily Goal", displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
                .foregroundStyle(.GREEN)
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    print("Saving...")
                }
            }
        }
    }
}

#Preview {
    HydrationInputView(viewModel: HydrationViewModel(type: .dailyGoal))
}
