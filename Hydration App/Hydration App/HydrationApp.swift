import SwiftUI
import SwiftData

@main
struct HydrationApp: App {
    private var coordinator: AppCoordinator
    @State private var currentTab = 0
    
    init() {
        guard let container = ContextManager.shared.container else {
            fatalError("Model container can't be initialized")
        }
        
        coordinator = AppCoordinator(container: container)
    }
    
    var body: some Scene {
        WindowGroup {
            TabView(selection: $currentTab) {
                coordinator.makeTodayView()
                    .tabItem {
                        Image(currentTab == 0 ? "Today_green" : "Today")
                        Text("Today")
                    }
                    .tag(0)
                
                coordinator.makeHistoryView()
                    .tabItem {
                        Image(systemName: "clock.arrow.trianglehead.counterclockwise.rotate.90")
                        Text("History")
                    }
                    .tag(1)
            }
            .tint(.GREEN)
        }
        .modelContainer(for: HydrationDay.self)
    }
}
