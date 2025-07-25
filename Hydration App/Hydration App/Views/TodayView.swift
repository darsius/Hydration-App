import SwiftUI

struct TodayView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Image("leaf_background")
                    .resizable()
                    .scaledToFill()
                    .blur(radius: 0.7)
                Color.black.opacity(0.3)
                
                VStack {
                    Text("20%")
                        .font(.glassPercentage)
                        .foregroundStyle(.GREEN)
                    Text("of 2000 ml Goal")
                        .foregroundStyle(.white)
                        .font(.bodyText)
                    
                    ZStack(alignment: .bottom) {
                        Image("Glass_empty")
                        Text("200 ml")
                            .padding(.bottom, TodayConstants.currentGlassVolume)
                            .font(.bodyText)
                    }
                    
                    HStack(spacing: TodayConstants.containerSpacing) {
                        ContainerButtonView(label: "200 ml")
                        ContainerButtonView(label: "400 ml")
                        ContainerButtonView(label: "500 ml")
                    }
                    .padding(.vertical, TodayConstants.containerVerticalPadding)
                    
                    Text("Happy you're back to track your healthy habit of staying hydrated.")
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.white)
                        .padding(.horizontal, TodayConstants.motivationalTextHorizontalPadding)
                        .font(.bodyText)
                }
                .padding(.top, TodayConstants.topPadding)
                
                VStack {
                    Divider()
                        .frame(height: TodayConstants.dividerHeight)
                        .background(.GREEN)
                    Spacer()
                }
                
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

#Preview {
    TodayView()
}
