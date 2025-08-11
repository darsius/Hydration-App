import SwiftUI

struct TodayView: View {
    @StateObject private var viewModel = TodayViewModel(
        dataSource: ChartDayDataSource(container: ContextManager.shared.container))
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                CustomDividerView()
                ZStack {
                    BackgroundImageView()
                    Color.black.opacity(0.3)
                    
                    VStack {
                        Text(String(format: "%.0f%%", viewModel.goalPrecentage))
                            .font(.largeBold)
                            .foregroundStyle(.GREEN)
                        Text("of \(viewModel.dailyGoal) \(viewModel.unit.rawValue) Goal")
                            .foregroundStyle(.white)
                            .font(.bodyText)
                        
                        ZStack(alignment: .bottom) {
                            GlassView(dailyGoal: viewModel.dailyGoal, currentAmount: viewModel.currentAmount)
                            
                            Text("\(viewModel.currentAmount) \(viewModel.unit.rawValue)")
                                .padding(.bottom, UIConstants.currentGlassVolume)
                                .font(.bodyBold)
                        }
                        
                        HStack(spacing: UIConstants.containerSpacing) {
                            ContainerButtonView(label: "\(viewModel.container1) \(viewModel.unit.rawValue)") {
                                viewModel.addAmount(amount: viewModel.container1)
                                
                            }
                            ContainerButtonView(label: "\(viewModel.container2) \(viewModel.unit.rawValue)") {
                                viewModel.addAmount(amount: viewModel.container2)
                            }
                            ContainerButtonView(label: "\(viewModel.container3) \(viewModel.unit.rawValue)") {
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
                            destination: SettingsView(viewModel: SettingsViewModel())) {
                                Image(.settings)
                            }
                    }
                }
                .toolbarBackground(Color(.systemBackground),for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
                
                .onChange(of: viewModel.unit) { oldValue, newValue in
                    // Muta in VM
                    Converter.convertAll(
                        dailyGoal: &viewModel.dailyGoal,
                        container1: &viewModel.container1,
                        container2: &viewModel.container2,
                        container3: &viewModel.container3,
                        from: oldValue,
                        to: newValue)
                }
            }
        }
    }
}

#Preview {
    TodayView()
}
