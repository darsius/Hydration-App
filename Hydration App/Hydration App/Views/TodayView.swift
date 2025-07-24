import SwiftUI

struct TodayView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Image("leaf_background")
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity)
                    .ignoresSafeArea(edges: .horizontal)
                    .blur(radius: 0.7)
                Color.black.opacity(0.3)
                
                VStack {
                    Text("20%")
                        .font(.system(size: 40))
                        .fontWeight(.bold)
                        .foregroundStyle(.GREEN)
                    Text("of 2000 ml Goal")
                        .foregroundStyle(.white)
                    
                    Image("Glass_empty")
                    
                    HStack(spacing: 8) {
                        ContainerButtonView(label: "200 ml")
                        ContainerButtonView(label: "400 ml")
                        ContainerButtonView(label: "500 ml")
                    }
                    .padding(.vertical, 30)
                    
                    
                    Text("Happy you're back to track your healthy habit of staying hydrated.")
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 70)
                }
                .padding(.top, 60)
                
                VStack(spacing: 0) {
                    Divider()
                        .frame(height: 1)
                        .background(.GREEN)
                    Spacer()
                }
                
            }
            .navigationBarTitle("Today's progress", displayMode: .inline)
            .toolbar {
                Button(action: {
                    print("navigating to settings")
                }) {
                    Image(systemName: "ellipsis.vertical.bubble")
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
