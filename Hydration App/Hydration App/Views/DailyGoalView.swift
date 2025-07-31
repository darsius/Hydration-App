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
        GeometryReader { geometry in
            ZStack {
                VStack(spacing: 0) {
                    CustomDivderView()
                    BackgroundImageView()
                }
                Color.black.opacity(0.3)
                
                VStack(spacing: 0) {
                    Text("Here you can set your hydration goal based on your preferred unit of measurement")
                        .multilineTextAlignment(.center)
                        .font(.bodyText)
                        .padding(.horizontal, UIConstants.informationalTextHorizontalPadding)
                        .padding(.top, UIConstants.informationalTextTopPadding)
                    Spacer()
                    
                    VStack {
                        TextField("", text: $quantityTextInput)
                            .multilineTextAlignment(.center)
                            .keyboardType(.numberPad)
                            .focused($focus)
                            .font(.largeTitle)
                            .frame(width: UIConstants.textFieldWidth, height:UIConstants.textFieldHeight)
                            .overlay {
                                RoundedRectangle(cornerRadius: UIConstants.textFieldCornerRadius)
                                    .stroke(Color.appGreen, lineWidth: UIConstants.textFieldBorderWidth)
                            }
                        Text("mililiters (ml)")
                            .font(.title)
                            .padding(.bottom, UIConstants.textBottomPadding)
                    }
                    .onAppear {
                        focus = true
                    }
                    Spacer()
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .ignoresSafeArea(.keyboard)
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("Daily Goal", displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
                .foregroundStyle(Color.appGreen)
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


