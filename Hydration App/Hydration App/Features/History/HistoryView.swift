import SwiftUI
import Charts
import SwiftData

struct HistoryView: View {
    @StateObject var viewModel: HistoryViewModel
    
    var body: some View {
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
                            chartView()
                                .frame(height: UIConstants.chartFrameHeight)
                                .padding(.horizontal, UIConstants.chartHorizontalPadding)
                        }
                        
                        VStack {
                            ForEach(viewModel.chartDays, id: \.id) { chartDay in
                                if chartDay.dailyGoal > 0 {
                                    listRowView(chartDay: chartDay)
                                }
                            }
                        }
                        .padding(.top, UIConstants.containerSpacing)
                        .padding(.horizontal, UIConstants.historyListRowHorizontalPadding)
                    }
                    .navigationBarTitle("History", displayMode: .inline)
                }
                .padding(.top, UIConstants.scrollViewTopPadding)
            }
        }
    }
    
    func listRowView(chartDay: ChartDay) -> some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading, spacing: UIConstants.listRowVerticalSpacing) {
                    Text(chartDay.date.longFormat)
                        .font(.bodyText)
                        .foregroundStyle(.gray)
                    Text("\(chartDay.currentAmount) \(chartDay.unit)")
                        .font(.regularText)
                    Text("\(chartDay.goalPrecentage) % ")
                        .foregroundStyle(Color(UIColor.label))
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
                .background(Color(UIColor.systemGray4))
        }
    }
    
    func chartView() -> some View {
        Chart(viewModel.chartDays, id: \.id) { chartDay in
            BarMark(
                x: .value("Day", chartDay.date, unit: .day),
                yStart: .value("Zero", 0),
                yEnd: .value("Goal", chartDay.dailyGoal),
                width: .ratio(UIConstants.barMarWidthRatio)
            )
            .foregroundStyle(Color(UIColor.systemGray4))
            
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
                let isFirst = value.index == 0
                let isLast = value.index == viewModel.chartDays.count - 1
                
                AxisValueLabel() {
                    Image(systemName: "square.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: UIConstants.chartDaySquareWidth, height: UIConstants.chartDaySquareHeight)
                        .foregroundColor(isFirst || isLast ? Color(UIColor.label) : .gray)
                }
            }
            
            AxisMarks(values: viewModel.chartDays.map { $0.date.startOfDay }) { value in
                if let date = value.as(Date.self),
                   let index = viewModel.chartDays.firstIndex(where: { $0.date.startOfDay == date }),
                   index == 0 || index == viewModel.chartDays.count - 1 {
                    AxisValueLabel(
                        anchor: value.index == 0 ? .topTrailing : .topLeading
                    ) {
                        Text(date.shortFormat)
                            .padding(.top, UIConstants.datePadding)
                            .font(.chartLegend)
                            .foregroundStyle(Color(UIColor.label))
                            .offset(x: value.index == 0 ? UIConstants.dateOffset : 0)
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
