import SwiftUI
import Charts
import SwiftData

struct HistoryView: View {
    @StateObject var viewModel = HistoryViewModel(
        dataSource: ChartDayDataSource(container: ContextManager.shared.container),
        chartDayGenerator: ChartDayGenerator())
    
    var body: some View {
        let sortedChartDays = viewModel.chartDays.sorted { $0.date < $1.date }
        let firstDate = sortedChartDays.first?.date.startOfDay ?? Date().startOfDay
        let lastDate = sortedChartDays.last?.date.startOfDay ?? Date().startOfDay
        
        NavigationStack {
            VStack(spacing: 0) {
                CustomDividerView()
                ScrollView {
                    LazyVStack() {
                        Text("Here you can see your hydration data for the last 30 days")
                            .multilineTextAlignment(.center)
                            .font(.regularText)
                            .padding(.horizontal, UIConstants.historyTextHorizontalPadding)
                        
                        if viewModel.chartDays.isEmpty {
                            Text("No data from the last few days")
                                .multilineTextAlignment(.center)
                                .font(.title2)
                                .padding(.top, UIConstants.historyTextHorizontalPadding)
                        } else {
                            makeChart(firstDate, lastDate)
                                .frame(height: UIConstants.chartFrameHeight)
                                .padding(.horizontal, UIConstants.chartHorizontalPadding)
                        }
                        
                        VStack {
                            ForEach(viewModel.chartDays, id: \.id) { chartDay in
                                if chartDay.dailyGoal > 0 {
                                    makeListRow(chartDay: chartDay)
                                }
                            }
                        }
                        .padding(.top, UIConstants.containerSpacing)
                        .padding(.horizontal, UIConstants.historyListRowHorizontalPadding)
                    }
                    .onAppear {
                        viewModel.unitChanged(nil)
                    }
                    .navigationBarTitle("History", displayMode: .inline)
                }
                .padding(.top, UIConstants.scrollViewTopPadding)
            }
        }
    }
    
    func makeListRow(chartDay: ChartDay) -> some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading, spacing: UIConstants.listRowVerticalSpacing) {
                    Text(chartDay.date.longFormat)
                        .font(.bodyText)
                        .foregroundStyle(.gray)
                    Text("\(chartDay.currentAmount) \(chartDay.unit)")
                        .font(.regularText)
                    Text("\(chartDay.goalPrecentage) % ")
                        .foregroundStyle(.white)
                        .font(.bodyBold) +
                    Text("out of \(chartDay.dailyGoal) \(chartDay.unit) Goal")
                        .foregroundStyle(.gray)
                        .font(.bodyText)
                }
                Spacer()
                Image(.checkmarkGoal)
                    .opacity((chartDay.currentAmount >= chartDay.dailyGoal) && chartDay.dailyGoal != 0 ? 1 : 0)
            }
            .padding(.horizontal, UIConstants.historyListRowHorizontalPadding)
            Divider()
                .frame(height: UIConstants.dividerHeight)
                .background(Color.lightGray)
        }
    }
    
    func makeChart(_ firstDate: Date, _ lastDate: Date) -> some View {
        
        Chart(viewModel.chartDays, id: \.id) { chartDay in
            BarMark(
                x: .value("Day", chartDay.date, unit: .day),
                yStart: .value("Zero", 0),
                yEnd: .value("Goal", chartDay.dailyGoal),
                width: .ratio(UIConstants.barMarWidthRatio)
            )
            .foregroundStyle(Color.lightGray)
            
            BarMark(
                x: .value("Day", chartDay.date, unit: .day),
                yStart: .value("Zero", 0),
                yEnd: .value("Amount", chartDay.currentAmount),
                width: .ratio(UIConstants.barMarWidthRatio)
            )
            .foregroundStyle(chartDay.currentAmount < chartDay.dailyGoal ? Color.appYellow : Color.appGreen)
        }
        .chartXAxis {
            AxisMarks(values: viewModel.chartDays.map { $0.date.startOfDay }) { value in
                if let date = value.as(Date.self) {
                    let isFirst = date.startOfDay == firstDate
                    let isLast = date.startOfDay == lastDate
                    
                    AxisValueLabel() {
                        Image(systemName: "square.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIConstants.chartDaySquareWidth, height: UIConstants.chartDaySquareHeight)
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
                            .padding(.top, UIConstants.datePadding)
                            .font(.chartLegend)
                            .foregroundStyle(Color.white)
                            .offset(x: value.index == 1 ? UIConstants.dateOffset : 0)
                    }
                }
            }
        }
        .chartYAxis {
            AxisMarks(position: .leading, values: [
                0,
                viewModel.maxDailyGoal / 4,
                viewModel.maxDailyGoal / 2,
                3 * viewModel.maxDailyGoal / 4,
                viewModel.maxDailyGoal
            ]) { value in
                AxisGridLine()
                AxisValueLabel()
            }
        }
    }
}

#Preview {
    HistoryView()
}
