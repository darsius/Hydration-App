////
////  t.swift
////  Hydration App
////
////  Created by Paraschiv, Darius on 31.07.2025.
////
//
//import SwiftUI
//
//struct t: View {
//    var body: some View {
//        ZStack {
//            VStack(spacing: 0) {
//                CustomDivderView()
//                BackgroundImageView()
//            }
//            Color.black.opacity(0.3)
//            
//            VStack(spacing: 0) {
//                Text(viewModel.informationalDescription)
//                    .multilineTextAlignment(.center)
//                    .foregroundStyle(.white)
//                    .font(.bodyText)
//                    .padding(.horizontal, HydrationInputConstants.informationalTextHorizontalPadding)
//                    .padding(.top, HydrationInputConstants.informationalTextTopPadding)
//                Spacer()
//                
//                VStack {
//                    TextField("", value: $textFieldInput, formatter: NumberFormatter())
//                        .multilineTextAlignment(.center)
//                        .keyboardType(.numberPad)
//                        .focused($focus)
//                        .font(.dailyGoal)
//                        .frame(width: HydrationInputConstants.textFieldWidth, height: HydrationInputConstants.textFieldHeight)
//                        .overlay {
//                            RoundedRectangle(cornerRadius: HydrationInputConstants.textFieldCornerRadius)
//                                .stroke(Color.GREEN, lineWidth: HydrationInputConstants.textFieldBorderWidth)
//                        }
//                    
//                    Text("mililiters (ml)")
//                        .font(.title)
//                        .padding(.bottom, HydrationInputConstants.textBottomPadding)
//                }
//                .onAppear {
//                    focus = true
//                    textFieldInput = inputValue
//                    print("temporary value is: \(textFieldInput)")
//                }
//                Spacer()
//            }
//        }
//    }
//}
//
//#Preview {
//    t()
//}
