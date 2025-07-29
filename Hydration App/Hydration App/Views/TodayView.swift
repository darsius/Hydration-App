import SwiftUI

struct TodayView: View {
    @Environment(TodayProgressViewModel.self) private var viewModel
    
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
                        Text("of \(viewModel.model.dailyGoal) ml Goal")
                            .foregroundStyle(.white)
                            .font(.bodyText)
                        
                        ZStack(alignment: .bottom) {
                            Image("Glass_empty")
                            Text("\(viewModel.currentAmount) ml")
                                .padding(.bottom, TodayConstants.currentGlassVolume)
                                .font(.bodyText)
                        }
                        
                        HStack(spacing: TodayConstants.containerSpacing) {
                            ContainerButtonView(label: "200 ml") {
                                viewModel.addAmount(amount: 200)
                            }
                            ContainerButtonView(label: "400 ml") {
                                viewModel.addAmount(amount: 400)
                            }
                            ContainerButtonView(label: "500 ml") {
                                viewModel.addAmount(amount: 500)
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
                        NavigationLink(destination: SettingsView()) {
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
