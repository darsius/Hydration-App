import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var currentTab = 0
    
    var body: some View {
        TabView(selection: $currentTab) {
            TodayView()
                .tabItem {
                    Image(currentTab == 0 ? "Today_green" : "Today")
                    Text("Today")
                }
                .tag(0)
            
            HistoryView()
                .tabItem {
                    Image(systemName: "clock.arrow.trianglehead.counterclockwise.rotate.90")
                    Text("History")
                }
                .tag(1)
        }
        .tint(.GREEN)
    }
}

//#Preview {
//    ContentView()
//}
