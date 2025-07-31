//
//  HydrationInputView.swift
//  Hydration App
//
//  Created by Paraschiv, Darius on 28.07.2025.
//

import SwiftUI

struct HydrationInputView: View {
    var viewModel: HydrationInputViewModel
    @Environment(\.dismiss) private var dismiss
    @FocusState private var focus: Bool
    
    @Binding var inputValue: Int
    @State private var textFieldInput: Int = 0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack(spacing: 0) {
                    CustomDivderView()
                    BackgroundImageView()
                }
                Color.black.opacity(0.3)
                
                VStack(spacing: 0) {
                    Text(viewModel.informationalDescription)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.white)
                        .font(.bodyText)
                        .padding(.horizontal, HydrationInputConstants.informationalTextHorizontalPadding)
                        .padding(.top, HydrationInputConstants.informationalTextTopPadding)
                    Spacer()
                    
                    VStack {
                        TextField("", value: $textFieldInput, formatter: NumberFormatter())
                            .multilineTextAlignment(.center)
                            .keyboardType(.numberPad)
                            .focused($focus)
                            .font(.dailyGoal)
                            .frame(width: HydrationInputConstants.textFieldWidth, height: HydrationInputConstants.textFieldHeight)
                            .overlay {
                                RoundedRectangle(cornerRadius: HydrationInputConstants.textFieldCornerRadius)
                                    .stroke(Color.GREEN, lineWidth: HydrationInputConstants.textFieldBorderWidth)
                            }
                        
                        Text("mililiters (ml)")
                            .font(.title)
                            .padding(.bottom, HydrationInputConstants.textBottomPadding)
                    }
                    .onAppear {
                        focus = true
                        textFieldInput = inputValue
                    }
                    Spacer()
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .ignoresSafeArea(.keyboard)
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle(viewModel.viewType.navbarTitle, displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
                .foregroundStyle(.GREEN)
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    inputValue = textFieldInput
                    dismiss()
                }
            }
        }
    }
}
//
//#Preview {
//    HydrationInputView(viewModel: HydrationViewModel(type: .dailyGoal))
//}
