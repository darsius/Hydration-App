import SwiftUI
import SwiftData

@main
struct HydrationApp: App {
    @State private var todayViewModel = TodayViewModel()
    @State private var settingsViewModel = SettingsViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(todayViewModel)
                .environment(settingsViewModel)
        }
    }
}
