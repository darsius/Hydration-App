import SwiftUI
import SwiftData

@main
struct HydrationApp: App {
    @State private var todayProgressViewModel = TodayProgressViewModel(model: TodayProgress(dailyGoal: 123, currentAmount: 124))
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(todayProgressViewModel)
        }
    }
}
