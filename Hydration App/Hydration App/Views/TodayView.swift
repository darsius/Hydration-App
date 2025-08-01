import SwiftUI

struct TodayView: View {
    @State private var viewModel = TodayViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                CustomDividerView()
                ZStack {
                    BackgroundImageView()
                    Color.black.opacity(0.3)
                    
                    VStack {
                        Text(String(format: "%.0f%%", viewModel.goalPrecentage))
                            .font(.bodyBold)
                            .foregroundStyle(.GREEN)
                        Text("of \(viewModel.dailyGoal) \(viewModel.unit) Goal")
                            .foregroundStyle(.white)
                            .font(.bodyText)
                        
                        ZStack(alignment: .bottom) {
                            GlassView(dailyGoal: viewModel.dailyGoal, currentAmount: viewModel.currentAmount)
                            
                            Text("\(viewModel.currentAmount) \(viewModel.unit)")
                                .padding(.bottom, UIConstants.currentGlassVolume)
                                .font(.bodyBold)
                        }
                        
                        HStack(spacing: UIConstants.containerSpacing) {
                            ContainerButtonView(label: "\(viewModel.container1) \(viewModel.unit)") {
                                viewModel.addAmount(amount: viewModel.container1)
                                
                            }
                            ContainerButtonView(label: "\(viewModel.container2) \(viewModel.unit)") {
                                viewModel.addAmount(amount: viewModel.container2)
                            }
                            ContainerButtonView(label: "\(viewModel.container3) \(viewModel.unit)") {
                                viewModel.addAmount(amount: viewModel.container3)
                            }
                        }
                        .padding(.vertical, UIConstants.containerVerticalPadding)
                        
                        Text("Happy you're back to track your healthy habit of staying hydrated.")
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.white)
                            .padding(.horizontal, UIConstants.greetingTextHorizontalPadding)
                            .font(.bodyText)
                    }
                    .padding(.top, UIConstants.topPadding)
                }
                .navigationBarTitle("Today's progress", displayMode: .inline)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        NavigationLink(
                            destination: SettingsView(
                                viewModel: SettingsViewModel(),
                                dailyGoal: $viewModel.dailyGoal,
                                currentAmount: $viewModel.currentAmount,
                                container1: $viewModel.container1,
                                container2: $viewModel.container2,
                                container3: $viewModel.container3,
                                unit: $viewModel.unit)) {
                                    Image(.settings)
                                }
                    }
                }
                .toolbarBackground(Color(.systemBackground),for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
            }
        }
    }
}

#Preview {
    TodayView()
}
