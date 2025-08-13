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
    
    @ObservedObject var viewModel : HydrationInputViewModel
    
    @State private var textFieldInput: Int = 0
    
    let viewType: HydrationViewType
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack(spacing: 0) {
                    CustomDividerView()
                    BackgroundImageView()
                }
                Color.black.opacity(0.3)
                
                VStack(spacing: 0) {
                    Text(viewType.informationalDescription)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.white)
                        .font(.bodyText)
                        .padding(.horizontal, UIConstants.informationalTextHorizontalPadding)
                        .padding(.top, UIConstants.informationalTextTopPadding)
                    Spacer()
                    
                    VStack {
                        TextField("", value: $textFieldInput, formatter: NumberFormatter())
                            .multilineTextAlignment(.center)
                            .keyboardType(.numberPad)
                            .focused($focus)
                            .font(.largeTitle)
                            .foregroundStyle(.white)
                            .frame(width: UIConstants.textFieldWidth, height:UIConstants.textFieldHeight)
                            .overlay {
                                RoundedRectangle(cornerRadius: UIConstants.textFieldCornerRadius)
                                    .stroke(Color.appGreen, lineWidth: UIConstants.textFieldBorderWidth)
                            }
                        
                        Text(viewModel.unit.label)
                            .font(.title)
                            .foregroundStyle(.white)
                            .padding(.bottom, UIConstants.textBottomPadding)
                    }
                    .onAppear {
                        focus = true
                        textFieldInput = viewModel.initialValue
                    }
                    Spacer()
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .ignoresSafeArea(.keyboard)
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle(viewType.navbarTitle, displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
                .foregroundStyle(Color.appGreen)
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    viewModel.initialValue = textFieldInput
                    viewModel.saveValue(viewModel.initialValue)
                    dismiss()
                }
            }
        }
    }
}
