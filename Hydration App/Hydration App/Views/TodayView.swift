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
                        Text(String(format: "%.0f%%", 20))
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
                            ContainerButtonView(label: "100 ml") {
                                viewModel.addAmount(amount: 100)
                            }
                            ContainerButtonView(label: "22 ml") {
                                viewModel.addAmount(amount: 22)
                            }
                            ContainerButtonView(label: "44 ml") {
                                viewModel.addAmount(amount: 44)
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
                        NavigationLink(destination: SettingsView(dailyGoal: $viewModel.dailyGoal)) {
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
