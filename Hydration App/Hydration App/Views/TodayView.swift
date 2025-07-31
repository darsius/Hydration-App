import SwiftUI

struct TodayView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: 0) {
                    CustomDivderView()
                    BackgroundImageView()
                }
                Color.black.opacity(0.3)
                
                VStack {
                    Text("20%")
                        .font(.largeBold)
                        .foregroundStyle(.GREEN)
                    Text("of 2000 ml Goal")
                        .foregroundStyle(.white)
                        .font(.bodyText)
                    
                    ZStack(alignment: .bottom) {
                        Image("Glass_empty")
                        Text("200 ml")
                            .padding(.bottom, UIConstants.currentGlassVolume)
                            .font(.bodyText)
                    }
                    
                    HStack(spacing: UIConstants.containerSpacing) {
                        ContainerButtonView(label: "200 ml")
                        ContainerButtonView(label: "400 ml")
                        ContainerButtonView(label: "500 ml")
                    }
                    .padding(.vertical, UIConstants.containerVerticalPadding)
                    
                    Text("Happy you're back to track your healthy habit of staying hydrated.")
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.white)
                        .font(.bodyText)
                }
                .padding(.top, UIConstants.topPadding)
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
