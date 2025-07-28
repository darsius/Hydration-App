//
//  DailyGoalView.swift
//  Hydration App
//
//  Created by Paraschiv, Darius on 25.07.2025.
//

import SwiftUI

struct DailyGoalView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var quantityTextInput = "2000"
    @FocusState private var focus: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            CustomDivderView()
            ZStack {
                BackgroundImageView()
                VStack(spacing: 100) {
                    Text("Here you can set your hydration goal based on your preferred unit of measurement")
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 100)

                    VStack {
                        TextField("", text: $quantityTextInput)
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
    DailyGoalView()
}
