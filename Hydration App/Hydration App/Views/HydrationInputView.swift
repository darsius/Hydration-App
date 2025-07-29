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
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack(spacing: 0) {
                    CustomDivderView()
                    BackgroundImageView()
                }
                Color.black.opacity(0.3)
                
                VStack(spacing: 0) {
                    Text("viewModel.type.informationalDescription")
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.white)
                        .font(.bodyText)
                        .padding(.horizontal, HydrationInputConstants.informationalTextHorizontalPadding)
                        .padding(.top, HydrationInputConstants.informationalTextTopPadding)
                    Spacer()
                    
                    VStack {
//                        TextField("", value: $viewModel.amount, formatter: NumberFormatter())
//                            .multilineTextAlignment(.center)
//                            .keyboardType(.numberPad)
//                            .focused($focus)
//                            .font(.dailyGoal)
//                            .frame(width: HydrationInputConstants.textFieldWidth, height: HydrationInputConstants.textFieldHeight)
//                            .overlay {
//                                RoundedRectangle(cornerRadius: HydrationInputConstants.textFieldCornerRadius)
//                                    .stroke(Color.GREEN, lineWidth: HydrationInputConstants.textFieldBorderWidth)
//                            }
                        
                        Text("mililiters (ml)")
                            .font(.title)
                            .padding(.bottom, HydrationInputConstants.textBottomPadding)
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
//
//#Preview {
//    HydrationInputView(viewModel: HydrationViewModel(type: .dailyGoal))
//}
