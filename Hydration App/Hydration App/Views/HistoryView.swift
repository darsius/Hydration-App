import SwiftUI
import Charts
import SwiftData

struct HistoryView: View {
    @Query() private var chartDays: [ChartDay]
    @Environment(\.modelContext) private var context
    
    var maxDaily: Int {
        chartDays.map { $0.dailyGoal }.max() ?? 2000
    }
    
    var allEmptyDays: Bool {
        chartDays.allSatisfy { $0.isEmpty }
    }
    
    var body: some View {
        let sortedChartDays = chartDays.sorted { $0.date < $1.date }
        let firstDate = sortedChartDays.first?.date.startOfDay ?? Date().startOfDay
        let lastDate = sortedChartDays.last?.date.startOfDay ?? Date().startOfDay
        
        ScrollView{
            LazyVStack(spacing: 10) {
                Text("Here you can see your hydration data for the last 30 days")
                    .multilineTextAlignment(.center)
                
                Chart(chartDays, id: \.id) { chartDay in
                    BarMark(
                        x: .value("Day", chartDay.date, unit: .day),
                        yStart: .value("Zero", 0),
                        yEnd: .value("Goal", chartDay.dailyGoal),
                        width: .ratio(0.4)
                    )
                    .foregroundStyle(Color.gray.opacity(0.3))
                    
                    BarMark(
                        x: .value("Day", chartDay.date, unit: .day),
                        yStart: .value("Zero", 0),
                        yEnd: .value("Amount", chartDay.currentAmount),
                        width: .ratio(0.4)
                    )
                    .foregroundStyle(chartDay.currentAmount < chartDay.dailyGoal ? Color.orange : Color.green)
                }
                .chartXAxis {
                    AxisMarks(values: chartDays.map { $0.date.startOfDay }) { value in
                        if let date = value.as(Date.self) {
                            let isFirst = date.startOfDay == firstDate
                            let isLast = date.startOfDay == lastDate
    
                            AxisValueLabel() {
                                Image(systemName: "square.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 5, height: 5)
                                    .foregroundColor(isFirst || isLast ? .white : .gray)
                            }
                        }
                    }
                    
                    AxisMarks(values: [firstDate, lastDate]) { value in
                        if let date = value.as(Date.self) {
                            AxisValueLabel(
                                anchor: value.index == 1 ? .topTrailing : .topLeading
                            ) {
                                Text(date.shortFormat)
                                    .padding(.top, 10)
                                    .offset(x: value.index == 1 ? 15 : 0)
                            }
                        }
                    }
                }
                .chartYAxis {
                    AxisMarks(position: .leading, values: [
                        0,
                        maxDaily / 4,
                        maxDaily / 2,
                        3 * maxDaily / 4,
                        maxDaily
                    ]) { value in
                        AxisGridLine()
                        AxisValueLabel()
                    }
                }
                .frame(height: 300)
                .padding(.horizontal, 10)
                
                VStack {
                    ForEach(sortedChartDays, id: \.id) { chartDay in
                        VStack(alignment: .leading) {
                            VStack(alignment: .leading) {
                                Text(chartDay.date.longFormat)
                                    .foregroundStyle(Color.gray)
                                Text("\(chartDay.currentAmount) ml")
                                    .font(.title2)
                                Text("75 % ")
                                    .foregroundStyle(.white) +
                                Text("\(chartDay.dailyGoal) ml Goal")
                                    .foregroundStyle(.gray)
                            }
                            .padding(.leading, 20)
                            Divider()
                                .background(Color.gray)
                        }
                    }
                }
                .padding(.top, 2)
                .padding(.horizontal, 12)
                
            }
            .task {
                if chartDays.isEmpty {
                    generateChartDays()
                }
            }
        }
    }
    
    func generateChartDays(count: Int = 30) {
        
        let calendar = Calendar.current
        
        let emptyModel = ChartDay(
            dailyGoal: 0,
            currentAmount: 0,
            date: calendar.date(byAdding: .day, value: -3, to: Date())!
        )
        context.insert(emptyModel)
        
        for i in 0..<count {
            if (i != 3) {
                let model = ChartDay(
                    dailyGoal: Int.random(in: 1600...2300),
                    currentAmount: Int.random(in: 1400...2300),
                    date: calendar.date(byAdding: .day, value: -i, to: Date())!
                )
                context.insert(model)
            }
        }
    }
    
    
    func deleteAll<T: PersistentModel>(_ modelType: T.Type, in context: ModelContext) {
        let descriptor = FetchDescriptor<T>()
        
        do {
            let results = try context.fetch(descriptor)
            for object in results {
                context.delete(object)
            }
            try context.save()
        } catch {
            print("Eroare la ștergerea tuturor obiectelor: \(error)")
        }
    }
    
    private func emptyContext() {
        do {
            try context.delete(model: ChartDay.self)
            try context.save()
        } catch {}
    }
}

#Preview {
    HistoryView()
}
