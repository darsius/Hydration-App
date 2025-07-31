import SwiftUI

struct TodayView: View {
    @State private var viewModel = TodayViewModel()

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                CustomDivderView()
                ZStack {
                    BackgroundImageView()
                    Color.black.opacity(0.3)
                    
                    VStack {
                        Text(String(format: "%.0f%%", viewModel.goalPrecentage))
                            .font(.glassPercentage)
                            .foregroundStyle(.GREEN)
                        Text("of \(viewModel.dailyGoal) \(viewModel.unit) Goal")
                            .foregroundStyle(.white)
                            .font(.bodyText)
                        
                        ZStack(alignment: .bottom) {
                            Image("Glass_empty")
                            Text("\(viewModel.currentAmount) \(viewModel.unit)")
                                .padding(.bottom, TodayConstants.currentGlassVolume)
                                .font(.bodyText)
                        }
                        
                        HStack(spacing: TodayConstants.containerSpacing) {
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
                        .padding(.vertical, TodayConstants.containerVerticalPadding)
                        
                        Text("Happy you're back to track your healthy habit of staying hydrated.")
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.white)
                            .padding(.horizontal, TodayConstants.motivationalTextHorizontalPadding)
                            .font(.bodyText)
                    }
                    .padding(.top, TodayConstants.topPadding)
                }
                .navigationBarTitle("Today's progress", displayMode: .inline)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        NavigationLink(
                            destination: SettingsView(dailyGoal: $viewModel.dailyGoal,
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
