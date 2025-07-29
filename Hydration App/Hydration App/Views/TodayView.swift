import SwiftUI

struct TodayView: View {
    @Environment(TodayViewModel.self) private var viewModel
    @Environment(SettingsViewModel.self) private var settingsViewModel

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                CustomDivderView()
                ZStack {
                    BackgroundImageView()
                    Color.black.opacity(0.3)
                    
                    VStack {
                        Text(String(format: "%.0f%%", viewModel.currentGoalPrecentage))
                            .font(.glassPercentage)
                            .foregroundStyle(.GREEN)
                        Text("of \(viewModel.dailyGoal) ml Goal")
                            .foregroundStyle(.white)
                            .font(.bodyText)
                        
                        ZStack(alignment: .bottom) {
                            Image("Glass_empty")
                            Text("\(viewModel.currentAmount) ml")
                                .padding(.bottom, TodayConstants.currentGlassVolume)
                                .font(.bodyText)
                        }
                        
                        HStack(spacing: TodayConstants.containerSpacing) {
                            ContainerButtonView(label: "\(settingsViewModel.container1.amount) ml") {
                                viewModel.addAmount(amount: settingsViewModel.container1.amount)
                            }
                            ContainerButtonView(label: "\(settingsViewModel.container2.amount) ml") {
                                viewModel.addAmount(amount: settingsViewModel.container2.amount)
                            }
                            ContainerButtonView(label: "\(settingsViewModel.container3.amount) ml") {
                                viewModel.addAmount(amount: settingsViewModel.container3.amount)
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
                        NavigationLink(destination: SettingsView(viewModel: settingsViewModel)) {
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

//#Preview {
//    TodayView()
//}
