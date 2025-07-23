import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        TabView {
            TodayView()
                .tabItem {
                    Image(systemName: "rectangle.portrait")
                    Text("Today")
                }
            HistoryView()
                .tabItem {
                    Image(systemName: "clock.arrow.trianglehead.counterclockwise.rotate.90")
                    Text("History")
                }
        }
    }
}

#Preview {
    ContentView()
}
